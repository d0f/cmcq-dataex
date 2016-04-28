package com.asiainfo.dacp.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import com.asiainfo.dacp.jdbc.JdbcTemplate;
import com.asiainfo.dacp.models.Api;
import com.asiainfo.dacp.models.ApiParam;
import com.asiainfo.dacp.models.ReturnCode;

@Repository
public class ApiDao {
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Api getApi(String apiId){
		final Api api = new Api();
		final List<ApiParam> apiParamList = new ArrayList<ApiParam>();
		JdbcTemplate jdbcTemplate = new JdbcTemplate();
		
		jdbcTemplate.query("select * from dacp_dataex_apiparam where api_id = '"+apiId+"' ",
				new ResultSetExtractor() {
					@Override
					public Object extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						while (rs.next()) {							
							ApiParam apiParam = new ApiParam();
							apiParam.setParaKey(rs.getString("param"));
							//apiParam.setParentNodeID(apiId);
							apiParam.setParaOperType("ADD");//ADD,MOD,DEL
							apiParam.setParaName(rs.getString("param_name"));//
							apiParam.setEntryOrExit(0);//0入参,1出参
							apiParam.setIsNull("是".equals(rs.getString("required"))?0:1);//是否必填 0是,1否
							apiParam.setDefValue(rs.getString("default_val"));								
							apiParamList.add(apiParam);
						}
						return null;
					}
				});
		jdbcTemplate.query("select * from dacp_dataex_apibody where api_id = '"+apiId+"' ",
				new ResultSetExtractor() {
			@Override
			public Object extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				while (rs.next()) {
					ApiParam apiParam = new ApiParam();
					
					apiParam.setParaKey(rs.getString("field"));
					//apiParam.setParentNodeID(apiId);
					apiParam.setParaOperType("ADD");//ADD,DEL
					apiParam.setParaName(rs.getString("field_name"));//
					apiParam.setEntryOrExit(1);//0入参,1出参
					apiParam.setIsNull(1);
					//apiParam.setDefValue(rs.getString("default_val"));
					
					apiParamList.add(apiParam);
				}
				return null;
			}
		});
		jdbcTemplate.query("select * from dacp_dataex_api  where api_id = '"+apiId+"' ",
				new ResultSetExtractor() {
			@Override
			public Object extractData(ResultSet rs)
					throws SQLException, DataAccessException {
				while (rs.next()) {
					api.setApiKey(rs.getString("request_url"));
					api.setOperType("发布".equals(rs.getString("state"))?"ADD":"MOD");//ADD,MOD,DEL
					api.setServiceId("BigDataService");
					api.setGoodsId("20160316000026040");
					api.setApiName(rs.getString("api_label"));
					api.setRemark(rs.getString("remark"));
					api.setRequestType("POST".equals(rs.getString("request_method"))?"1":"0");//新增时必填。,0：GET 1：POST,默认为1 post
					api.setOnlineFlag("发布".equals(rs.getString("state"))?1:0);//API的上线状态	0下线,1上线（只有上线状态的才能被订购）。,（不传的话，默认为上线状态）,
					api.setProvider("asiainfoBI");
				}
				api.setApiParamList(apiParamList);
				return null;
			}
		});
		
		List<ReturnCode> returnCodeList = new ArrayList<ReturnCode>();
		ReturnCode errCode = new ReturnCode();
		ReturnCode errMsg = new ReturnCode();
		errCode.setCodeInfo("错误编码");
		errCode.setCodeName("error_code");
		errCode.setCodeOperType("ADD");
		errCode.setRemark("");
		errCode.setSolution("");
		returnCodeList.add(errCode);
		errMsg.setCodeInfo("错误描述");
		errMsg.setCodeName("error");
		errMsg.setCodeOperType("ADD");
		errMsg.setRemark("");
		errMsg.setSolution("");
		returnCodeList.add(errMsg);
		api.setReturnCodeList(returnCodeList);
	
		return api;
	}
}
