package com.asiainfo.dacp.models;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder={"paraKey","parentNodeID","paraOperType","paraName","entryOrExit","isNull","defValue"})
public class ApiParam {
    @XmlElement(name="paraKey",required=true)
    private String paraKey;
    @XmlElement(name="parentNodeID")
    private String parentNodeID;
    @XmlElement(name="paraOperType",required=true)
    private String paraOperType;
    @XmlElement(name="paraName")
    private String paraName;
    @XmlElement(name="entryOrExit")
    private int entryOrExit;
    @XmlElement(name="isNull")
    private int isNull;
    @XmlElement(name="defValue")
    private String defValue;
	public String getParaKey() {
		return paraKey;
	}
	public void setParaKey(String paraKey) {
		this.paraKey = paraKey;
	}
	public String getParentNodeID() {
		return parentNodeID;
	}
	public void setParentNodeID(String parentNodeID) {
		this.parentNodeID = parentNodeID;
	}
	public String getParaOperType() {
		return paraOperType;
	}
	public void setParaOperType(String paraOperType) {
		this.paraOperType = paraOperType;
	}
	public String getParaName() {
		return paraName;
	}
	public void setParaName(String paraName) {
		this.paraName = paraName;
	}
	public int getEntryOrExit() {
		return entryOrExit;
	}
	public void setEntryOrExit(int entryOrExit) {
		this.entryOrExit = entryOrExit;
	}
	public int getIsNull() {
		return isNull;
	}
	public void setIsNull(int isNull) {
		this.isNull = isNull;
	}
	public String getDefValue() {
		return defValue;
	}
	public void setDefValue(String defValue) {
		this.defValue = defValue;
	}
    
    

}