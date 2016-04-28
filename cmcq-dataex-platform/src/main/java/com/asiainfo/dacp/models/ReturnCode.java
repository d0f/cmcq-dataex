package com.asiainfo.dacp.models;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder={"codeName","codeOperType","codeInfo","remark","solution"})
public class ReturnCode {
    @XmlElement(name="codeName",required=true)
    private String codeName;
    @XmlElement(name="codeOperType",required=true)
    private String codeOperType;
    @XmlElement(name="codeInfo")
    private String codeInfo;
    @XmlElement(name="remark")
    private String remark;
    @XmlElement(name="solution")
    private String solution;
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getCodeOperType() {
		return codeOperType;
	}
	public void setCodeOperType(String codeOperType) {
		this.codeOperType = codeOperType;
	}
	public String getCodeInfo() {
		return codeInfo;
	}
	public void setCodeInfo(String codeInfo) {
		this.codeInfo = codeInfo;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSolution() {
		return solution;
	}
	public void setSolution(String solution) {
		this.solution = solution;
	}
    
    
    
}