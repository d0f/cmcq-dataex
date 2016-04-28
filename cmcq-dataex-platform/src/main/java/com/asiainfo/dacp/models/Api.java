package com.asiainfo.dacp.models;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="ROOT")
@XmlType(propOrder={"apiKey","operType","serviceId","goodsId","showId","apiName","remark","requestType","onlineFlag","provider","apiParamList","returnCodeLi"})
public class Api {

    @XmlElement(name="apiKey",required=true)
    private String apiKey;
    @XmlElement(name="operType",required=true)
    private String operType;
    @XmlElement(name="serviceId",required=true)
    private String serviceId;
    @XmlElement(name="goodsId",required=true)
    private String goodsId;
    @XmlElement(name="apiName",required=true)
    private String apiName;
    @XmlElement(name="remark")
    private String remark;
    @XmlElement(name="requestType")
    private String requestType;
    @XmlElement(name="onlineFlag")
    private int onlineFlag;
    @XmlElement(name="provider",required=true)
    private String provider;
    
    @XmlElementWrapper(name="apiParamList")
    private List<ApiParam> apiParamList;
    
    @XmlElementWrapper(name="returnCodeList")
    private List<ReturnCode> returnCodeList;

	public String getApiKey() {
		return apiKey;
	}

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getApiName() {
		return apiName;
	}

	public void setApiName(String apiName) {
		this.apiName = apiName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

	public int getOnlineFlag() {
		return onlineFlag;
	}

	public void setOnlineFlag(int onlineFlag) {
		this.onlineFlag = onlineFlag;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public List<ApiParam> getApiParamList() {
		return apiParamList;
	}

	public void setApiParamList(List<ApiParam> apiParamList) {
		this.apiParamList = apiParamList;
	}

	public List<ReturnCode> getReturnCodeList() {
		return returnCodeList;
	}

	public void setReturnCodeList(List<ReturnCode> returnCodeList) {
		this.returnCodeList = returnCodeList;
	}
    
    
}