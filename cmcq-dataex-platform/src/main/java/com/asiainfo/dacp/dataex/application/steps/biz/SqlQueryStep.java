package com.asiainfo.dacp.dataex.application.steps.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.dacp.dataex.application.DataExException;
import com.asiainfo.dacp.dataex.application.ErrorResponse;
import com.asiainfo.dacp.dataex.application.steps.Step;
import com.asiainfo.dacp.dataex.application.steps.StepPassVo;
import com.asiainfo.dacp.dataex.application.steps.StepPassVoParams;
import com.asiainfo.dacp.dataex.application.steps.StepReturnVo;
import com.asiainfo.dacp.jdbc.JdbcTemplate;

/**
 * SQL 查询
 * @author MeiKefu
 * @date 2015年7月16日
 */
public class SqlQueryStep implements Step {

	public StepReturnVo handle(StepPassVo stepPassVo,Map<String,Object> stepCfg) throws DataExException {
		ErrorResponse errorResponse = null;
		String dbName = (String) stepCfg.get("dataSource");
		String sqlTimeout = (String) stepCfg.get("sqlTimeout");
		if(dbName==null){
			dbName="dataSource";
		}
		String sql = (String) stepCfg.get("sql");
		if (sql == null) {
			return new StepReturnVo(false,new ErrorResponse(stepPassVo.getApiId(),"10114","SQL语句配置为空"));
		}
		List<String> paraNameList = paraNameList(sql);
		for (String paraname : paraNameList) {
			if (stepPassVo.getHttpParam().getParameter(paraname) == null) {
				errorResponse = new ErrorResponse(stepPassVo.getApiId(),"20001","{"+paraname+"}参数异常，未找到必选参数");
				return new StepReturnVo(false,errorResponse);
			}
		}
		sql = replacePara(sql, paraNameList, stepPassVo.getHttpParam());
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try{
			JdbcTemplate jdbcTemplate = new JdbcTemplate(dbName,false);
			if(StringUtils.isNotBlank(sqlTimeout)){//TODO 需要判断是否支持这个参数
				jdbcTemplate.setQueryTimeout(Integer.parseInt(sqlTimeout));
			}
			result = jdbcTemplate.queryForList(sql);
			
			stepPassVo.setChargingTimes(result.size());
			
		}catch(Exception e){
			e.printStackTrace();
			return new StepReturnVo(false,new ErrorResponse(stepPassVo.getApiId(),"21001","查询sql异常:"+e.getMessage()));
		}
		if(result.size()!=0){
			Map<String,Object> retMap = new HashMap<String,Object>();
			retMap.put("result", result);
			retMap.put("error_code", "0");
			retMap.put("error", "Processing the request succeeded!");
			StepReturnVo stepReturnVo = new StepReturnVo(true,retMap);
			stepPassVo.setReturnObject(result);
			return stepReturnVo;			
		}else{
			return new StepReturnVo(false,new ErrorResponse(stepPassVo.getApiId(),"21099","No information!"));
		}
	}

	/**提取参数名*/
	private List<String> paraNameList(String sql){
		//String s1 = "select * from {user_info} a,{user_sub} a where a.user_id = b.user_id";
		Pattern p = Pattern.compile("\\@P\\{([^\\}]*)\\}");
		Matcher m = p.matcher(sql);
		List<String> params = new ArrayList<String>();
		while(m.find()){
			params.add(m.group(1));
		}
		return params;
	}
	
	/**替换真实sql中的参数*/
	public String replacePara(String sql,List<String> paraNameList,StepPassVoParams request){
		for(String paraName:paraNameList){
			String paraVal = request.getParameter(paraName);
			sql = sql.replace("@P{"+paraName+"}", paraVal);
		}
		return sql;
	}
	
}
