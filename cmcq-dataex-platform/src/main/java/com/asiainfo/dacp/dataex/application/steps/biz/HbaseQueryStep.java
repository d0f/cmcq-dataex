package com.asiainfo.dacp.dataex.application.steps.biz;

import com.asiainfo.dacp.cache.Cache;
import com.asiainfo.dacp.core.BeanFactory;
import com.asiainfo.dacp.dataex.application.ErrorResponse;
import com.asiainfo.dacp.dataex.application.cache.DataExCacheManager;
import com.asiainfo.dacp.dataex.application.cache.vo.DataExApiVo;
import com.asiainfo.dacp.dataex.application.services.DataExConstants;
import com.asiainfo.dacp.dataex.application.steps.Step;
import com.asiainfo.dacp.dataex.application.steps.StepPassVo;
import com.asiainfo.dacp.dataex.application.steps.StepReturnVo;
import com.asiainfo.dacp.dataex.domain.api.models.DataExApiBody;
import com.google.common.collect.Maps;

import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.CellUtil;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.TableNotFoundException;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Table;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * hbase通过rowkey查询
 * 
 * @date 2016年1月13日
 */
public class HbaseQueryStep implements Step {

	private static DataExCacheManager openCacheManager = (DataExCacheManager) BeanFactory.getBean(DataExCacheManager.class);
	private Configuration conf = null;
	private Connection connection = null;

	public StepReturnVo handle(StepPassVo stepPassVo, Map<String, Object> stepCfg) {
		String searchType = (String) stepCfg.get("searchType");
		String hbaseCfg = DataExConstants.getInstance().getValue("HBASE_CFG", (String) stepCfg.get("quorum"));
		String htable = (String) stepCfg.get("htable");
		String quorum = hbaseCfg.split(":")[0];
		String clientPort = hbaseCfg.split(":")[1];
		boolean isKerberos = Boolean.valueOf((String) stepCfg.get("isKerberos"));
		String hbaseTimeOut = StringUtils.defaultIfBlank((String) stepCfg.get("hbaseTimeOut"), "30");
		int timeOut = Integer.parseInt(hbaseTimeOut) * 1000;

		String kerberosName = (String) stepCfg.get("kerberosName");
		
		String rowkey=null;
		String startRow=null;
		String stopRow=null;
		
		Object resultMap=null;
		try {
			if("get".equals(searchType)){
				Map<String, Map<String, Object>> hbaseMap = null;
				rowkey = stepPassVo.getHttpParam().getParameter("rowkey");
				hbaseMap = processResultToMap(getResult(quorum, clientPort, timeOut + "", htable, rowkey));				
				resultMap = processResult(stepPassVo, hbaseMap);
			}else if("scan".equals(searchType)){
				Map<String,  Object> hbaseMap = null;
				startRow = stepPassVo.getHttpParam().getParameter("startRow");
				stopRow = stepPassVo.getHttpParam().getParameter("stopRow");
				hbaseMap = processResultScnnerToMap(scanResult(quorum, clientPort, timeOut + "", htable, startRow,stopRow));				
				resultMap = processResultScanner(stepPassVo, hbaseMap);
				
			}else{
				ErrorResponse errResp = new ErrorResponse(stepPassVo.getApiId(), "10207", "hbase操作失败!");
				return new StepReturnVo(false, errResp);
			}
		} catch (TableNotFoundException e) {
			e.printStackTrace();
			ErrorResponse errResp = new ErrorResponse(stepPassVo.getApiId(), "10206", "hbase操作异常，表<" + htable + ">不存在!");
			return new StepReturnVo(false, errResp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		stepPassVo.setReturnObject(resultMap);

		if (resultMap != null) {
			Map<String, Object> retMap = new HashMap<String, Object>();
			retMap.put("result", resultMap);
			retMap.put("error_code", "0");
			retMap.put("error", "Processing the request succeeded!");
			return new StepReturnVo(true, retMap);
		} else {
			return new StepReturnVo(false, new ErrorResponse(stepPassVo.getApiId(), "21099", "No information!"));
		}

	}

	private Map<String, Map<String, Object>> processResult(StepPassVo stepPassVo, Map<String, Map<String, Object>> hbaseMap) {
		Cache<String, DataExApiVo> cacheApi = openCacheManager.getCache(DataExCacheManager.CacheName.DACP_DATAEX_API);
		List<DataExApiBody> apiBodys = cacheApi.get(stepPassVo.getApiId()).getDataExApi().getApiBodys();
		if (apiBodys == null || apiBodys.size() == 0) {
			return hbaseMap;
		}
		Map<String, Map<String, Object>> resultMap = Maps.newHashMap();
		for (DataExApiBody openApiBody : apiBodys) {
			if (StringUtils.isBlank(openApiBody.getParentField())) {
				continue;
			}
			for (String family : hbaseMap.keySet()) {
				Map<String, Object> columnMap = hbaseMap.get(family);
				for (String column : columnMap.keySet()) {
					if (StringUtils.equals(openApiBody.getParentField(), family) && StringUtils.equals(openApiBody.getField(), column)) {
						if (resultMap.containsKey(family)) {
							Map resultColMap = resultMap.get(family);
							resultColMap.put(column, columnMap.get(column));
						} else {
							Map<String, Object> resultColMap = Maps.newHashMap();
							resultColMap.put(column, columnMap.get(column));
							resultMap.put(family, resultColMap);
						}
					}
				}
			}
		}
		return resultMap.isEmpty()?null:resultMap;
	}
	
	private Map<String, Object> processResultScanner(StepPassVo stepPassVo, Map<String, Object> hbaseMap) {
		Map<String, Object> retMap=new HashMap<String, Object>();
		for(String key:hbaseMap.keySet()){
			Map<String, Map<String, Object>> proMap = (Map<String, Map<String, Object>>) hbaseMap.get(key);
			retMap.put(key, processResult(stepPassVo,  proMap));
		}
		return retMap;
	}

	public Map<String, Map<String, Object>> processResultToMap(Result rs) throws Exception {
		if (rs == null) {
			return null;
		}
		Map<String, Map<String, Object>> hbaseMap = new HashMap<String, Map<String, Object>>();
		for (Cell cell : rs.rawCells()) {
			String family = new String(CellUtil.cloneFamily(cell));
			if (hbaseMap.containsKey(family)) {
				Map<String, Object> colMap = hbaseMap.get(family);
				colMap.put(new String(CellUtil.cloneQualifier(cell)), new String(CellUtil.cloneValue(cell)));
			} else {
				Map<String, Object> colMap = new HashMap<String, Object>();
				colMap.put(new String(CellUtil.cloneQualifier(cell)), new String(CellUtil.cloneValue(cell)));
				hbaseMap.put(family, colMap);
			}
		}
		return hbaseMap;
	}
	
	public Map<String, Object> processResultScnnerToMap(ResultScanner rsScanner) throws Exception {
		if (rsScanner == null) {
			return null;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		for(Result result : rsScanner){
			map.put(new String(result.getRow()), processResultToMap(result));
		}
		return map;
	}

	public Result getResult(String quorum, String clientPort, String hbaseTimeOut, String tableName, String rowKey) throws TableNotFoundException {
		Table htable = null;
		Result rs = null;
		conf = HBaseConfiguration.create();
		conf.set("hbase.zookeeper.quorum", quorum);
		conf.set("hbase.zookeeper.property.clientPort", clientPort);
		conf.set("zookeeper.znode.parent", "/hbase");
		conf.set("zookeeper.session.timeout", hbaseTimeOut);

		try {
			if (connection == null) {
				connection = ConnectionFactory.createConnection(conf);
			}
			System.out.println("connection.isClosed:::::" + connection.isClosed());

			htable = connection.getTable(TableName.valueOf(tableName));
			rs = htable.get(new Get(rowKey.getBytes()));

		} catch (IOException e) {
			throw new TableNotFoundException();
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return rs;
	}
	
	public ResultScanner scanResult(String quorum, String clientPort, String hbaseTimeOut, String tableName, String startRow,String stopRow) throws TableNotFoundException {
		Table htable = null;
		ResultScanner rs = null;
		conf = HBaseConfiguration.create();
		conf.set("hbase.zookeeper.quorum", quorum);
		conf.set("hbase.zookeeper.property.clientPort", clientPort);
		conf.set("zookeeper.znode.parent", "/hbase");
		conf.set("zookeeper.session.timeout", hbaseTimeOut);
		
		try {
			if (connection == null) {
				connection = ConnectionFactory.createConnection(conf);
			}
			System.out.println("connection.isClosed:::::" + connection.isClosed());
			
			htable = connection.getTable(TableName.valueOf(tableName));
			Scan scan = new Scan();
			scan.setCacheBlocks(true);
			scan.setCaching(30000);
			scan.setStartRow(startRow.getBytes());
			scan.setStopRow(stopRow.getBytes());
			scan.setBatch(1000);
			rs = htable.getScanner(scan);
			
		} catch (IOException e) {
			throw new TableNotFoundException();
		}/* finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}*/
		return rs;
	}
}
