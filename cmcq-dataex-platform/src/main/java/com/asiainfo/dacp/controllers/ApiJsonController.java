package com.asiainfo.dacp.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import net.sf.json.JSONObject;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.PropertyNamingStrategy.PropertyNamingStrategyBase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asiainfo.dacp.core.Configuration;
import com.asiainfo.dacp.dao.ApiDao;

@Controller
@RequestMapping("/getApi")
public class ApiJsonController {
		
	@Autowired
	ApiDao apiDao;
	
	@RequestMapping("/json")
	@ResponseBody
	public String getApiJson(@RequestParam String apiId){
		ObjectMapper objMapper = new ObjectMapper();
		objMapper.setPropertyNamingStrategy(new CapitalizedPropertyNamingStrategy());
		try {
			return objMapper.writeValueAsString(apiDao.getApi(apiId));
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "error";
	}
	
	@RequestMapping("/sync")
	@ResponseBody
	public String syncMetaData(@RequestParam String apiId) {
		String errorMsg = "同步成功";
		String syncInterfaceServer = Configuration.getInstance().getProperty("com.asiainfo.dacp.controllers.ApiJsonController.syncInterfaceServer");

		String getTokenUrl = syncInterfaceServer+"/OAuth/restOauth2Server/access_token";
		String syncDataUrl = syncInterfaceServer+"/openapi/httpService/AutoAPIRegisterService?access_token=:access_token&method=autoAPIRegister&format=json";
		
		String tokenRet = sendRequestContent("grant_type=client_credentials&client_id=20160316000026036&client_secret=13ed3dea2d8d0646d4f7a4b0e5c57b35",getTokenUrl,"");
		System.out.println(tokenRet);
		if(tokenRet != null){
			JSONObject tokenJson = JSONObject.fromObject(tokenRet);
			String accessToken = tokenJson.getString("access_token");			
			
			if(accessToken!=null){
				String reqCon = getApiJson(apiId);
				System.out.println(reqCon);
				String resultInfo = sendRequestContent(reqCon,syncDataUrl.replaceAll(":access_token", accessToken),"application/json; charset=gbk");
				System.out.println(resultInfo);
				if(resultInfo!=null){
					JSONObject resultJson = JSONObject.fromObject(resultInfo);
					String resCode = resultJson.getString("res_code");
					if(!"0".equals(resCode)){
						errorMsg = resultJson.getString("res_desc");					
					}
				}else{
					errorMsg = "同步数据失败";
				}
			}else{
				errorMsg = "获取token失败";
			}			
		}else{
			errorMsg = "获取token失败";
		}	
		return errorMsg;
	}
	
	public String sendRequestContent(String requestContent,String openUrl,String contentType){
		String ret=null;
		
		URL url = null;
		BufferedReader in = null;
		HttpURLConnection urlConn = null;
		PrintWriter out = null;
		String sLine = null;
		StringBuffer sbBuf = new StringBuffer();
		
		try {
			url = new URL(openUrl);
			urlConn = (HttpURLConnection) url.openConnection();
			urlConn.setConnectTimeout(5000);
			urlConn.setReadTimeout(5000);
			
			urlConn.setRequestMethod("POST");
			urlConn.setDoInput(true);
			urlConn.setDoOutput(true);
			urlConn.setUseCaches(false);
			urlConn.setRequestProperty("Content-Type", contentType);
			urlConn.setRequestProperty("SOAPAcion", "");
			
			out = new PrintWriter(new OutputStreamWriter(urlConn.getOutputStream(),"gbk"));
			
			out.print(requestContent);
			out.flush();
			
			in = new BufferedReader(new InputStreamReader(urlConn.getInputStream(),"gbk"));
			
			while((sLine = in.readLine())!=null){
				sbBuf.append(sLine).append("\n");
			}
			ret= sbBuf.toString();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return ret;
	}
	
	class CapitalizedPropertyNamingStrategy extends PropertyNamingStrategyBase {
		 
	    @Override
	    public String translate(String propertyName) {
	        return propertyName.toUpperCase();
	    }
	 
	}
	
}
