<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta content="text/html" charset="UTF-8" />
<title>API详细介绍</title>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="icon" href="${mvcPath}/dacp-res/images/dacp_favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${mvcPath}/dacp-res/images/dacp_favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="${mvcPath}/dacp-res/dataex/css/docs.min.css" type="text/css" />
<link href="${mvcPath}/dacp-view/aijs/css/ai.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="${mvcPath}/dacp-view/aijs/css/font-awesome.min.css" type="text/css" />
 
<script type="text/javascript" src="${mvcPath}/dacp-lib/jquery/jquery-1.10.2.min.js"></script>
<script src="${mvcPath}/dacp-lib/cryptojs/aes.js" type="text/javascript"></script>
<script src="${mvcPath}/crypto/crypto-context.js" type="text/javascript"></script>
<script type="text/javascript" src="${mvcPath}/dacp-lib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${mvcPath}/dacp-lib/underscore/underscore-min.js"></script>
<script type="text/javascript" src="${mvcPath}/dacp-lib/backbone/backbone-min.js"></script>
<style type="text/css">
html, body, html, div, p, strong, span, em, i, img, dl, ol, ul, li, dt, dd {
    margin: 0px;
    padding: 0px;
    list-style: outside none none;
    font-family: "Microsoft Yahei","Hiragino Sans GB","Helvetica Neue",Arial,sans-serif;
}
.marginTop {
	margin: 30px 0 10px 0;
	background-color: #f5f5f5;
}
.marginTop li{
	font-size: 14px;
}
.ued_openapi_mar_top{
	margin-bottom: 20px;
	margin-left: -30px;
}
.ued_openapi_btn_button{
    float: right;
    color: white;
    border: none;
    margin-top: 10px;
    margin-right: 20px;
}
.ued_openapi_btn_sum .hot{
    color: #3199f4;
    background: url(../image/hot.gif) no-repeat;
    background-position: 100% 0%;
    padding-right: 25px;
}
#attr-nav .nav-tabs>li {
    margin-bottom: 0px;
}
#attr-nav ul .active a{
	color: white;
    background-color: #3099F5;
    border-style: dotted;
}
.app_content table {
    width: 100%;
    border: 1px solid #dddddd;
}
.app_content td {
    border: 1px solid #dddddd;
    line-height: 20px;
}
.modal-body table {
    width: 100%;
}
.modal-body td {
    border: 0px;
}
.modal-body td label{
    margin-left: 20px;
    font-size: 15px;
    color: black;
}
textarea{
	width: 100%;
    max-width: 100%;
    height: 300px;
    border: 1px solid #dddddd;
    background: #E8F2FF;
    font-size: 12px;
    line-height: 24px;
}
.api-name-list{
	border-right: 3px solid #ddd;
}
.api-name-list.nav-tabs>li>a {
	border-color: #FFFFFF !important;
    border-bottom-color: #FFFFFF !important;
}
.api-name-list.nav-tabs{
    border-color: #FFFFFF;
}
.api-name-list.nav-tabs li.active a{
	text-decoration: underline;
	color:#1E8CBE;
	font-size:13px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#attr-nav .nav-tabs").css('border-width','3px').css('border-bottom-color','#3099f5');
	  	$("#attr-nav ul .active a").css('background','#3099f5').css('color','white').css('border-style','dotted');
	  	$("#attr-nav li a").click(function(){
	  		$("#attr-nav li a").css('background','').css('color','');
	  		$(this).css('background','#3099f5').css('color','white').css('border-style','dotted');
	  	});
	});
</script>
<meta name="viewport" content="initial-scale=1.0,width=device-width,user-scalable=no" />
<link rel="stylesheet" href="${mvcPath}/dacp-res/dataex/css/homepage-one-field-long.css" type="text/css"/>
</head>
<body style="background-color:white;">
<#assign menuName = "apiCatalog" />
<div class="container">
	<ul class="breadcrumb marginTop">
		<li><i style="color:rgb(48, 153, 245)" class="glyphicon glyphicon-home"></i>&nbsp;当前所在位置：<a href="${mvcPath}/dataex">首页</a></li>
		<li><a href="${mvcPath}/dataex/api_catalog?category=${dataExApi.category}">${dataExApi.categoryLabel}</a> <span class="divider"></span></li>
		<li class="active"></li>
	</ul>
</div>
<div class="container">
	<div class="col-md-12" style="margin-bottom: 30px">
		<div class="col-lg-3 col-md-3">
			<div style="width:220px;height:200px;background-color: #F7C9C9;text-align: center;">
				<img src="${mvcPath}/dacp-res/dataex/images/demo.png" style="padding-top: 50px;">
			</div>
		</div>
		<div class="col-lg-9 col-md-9 ued_openapi_mar_top">
			<div class="col-md-12">
				<h4 style="font-size: 18px;float: left; margin-top: 10px;color: #3199f4;">${dataExApi.apiLabel}</h4>
			</div>
			<div class="col-md-12" style="line-height: 25px;font-size: 14px;">
    			<div><p style="color: black;float: left;">所属分类：</p>${dataExApi.categoryLabel}</div>
    			<div><p style="color: black;float: left;">状态：</p>${dataExApi.state}</div>
    			<div><p style="color: black;float: left;">返回类型：</p>${dataExApi.responseType!'JSON'}</div>
    			<div><p style="color: black;float: left;">服务介绍：</p>${(dataExApi.apiDescr)!""}</div>
			</div>    	
		</div>
	</div>
	<div class="col-md-12" id="attr-nav">
		<ul class="nav nav-tabs" style="font-size:14px;border-width: 4px;border-bottom-color: rgb(48, 153, 245);margin-bottom: 20px">
	        <li class="active"><a href="#tab2" data-toggle="tab">API</a></li>
	        <li><a href="#tab3" data-toggle="tab">接口参数</a></li>
	        <li><a href="#tab4" data-toggle="tab">返回码说明</a></li>
	        <li><a href="#tab5" data-toggle="tab">样例</a></li>
		</ul>
	</div>
	<div class="col-md-12">
		<div class="app_content tab-content">
			<div id="tab2" class="tab-pane active">
				<div class="row" style="line-height:2">
					<div class="col-md-2" style="border-right: 3px solid #ddd">
						<ul class="nav nav-tabs api-name-list">
							<li class="active"><a href="#${dataExApi.apiId}" data-toggle="tab">1.${dataExApi.apiLabel}</a></li>
						</ul>
					</div>
					<div class="tab-content col-md-10 api-content-list">
						<div id="${dataExApi.apiId}" class="tab-pane active">
						<div>接口地址：http://open.dacp.org/api${dataExApi.requestUrl}</div>
						<div>支持格式：JSON/XML</div>
						<div>请求方式：GET/POST</div>
						<div>请求示例：http://open.dacp.org/api${dataExApi.requestUrl}?token=Bh7f1A0K&appKey=您申请的APPKEY</div>
						</div>
					</div>
				</div>
			</div>
			<div id="tab3" class="tab-pane">
				<table>
					<tr><td>参数名</td><td>参数中文名</td><td>是否必填</td><td>默认值</td></tr>
					<#list dataExApi.apiParams as param>
						<tr><td>${param.param}</td><td>${param.paramName}</td><td>${param.required}</td><td>${param.param}</td></tr>
					</#list>
				</table>
			</div>
			<div id="tab4" class="tab-pane">
				<table>
					<tr><td>错误码</td><td>说明</td></tr>
					<tr><td>0</td><td>成功</td></tr>
					<tr><td>10001</td><td>错误的请求KEY</td></tr>
					<tr><td>10002</td><td>该KEY无请求权限</td></tr>
					<tr><td>10003</td><td>KEY过期</td></tr>
					<tr><td>10004</td><td>错误的SDK KEY</td></tr>
					<tr><td>10005</td><td>应用未审核超时，请提交认证</td></tr>
					<tr><td>10007</td><td>未知的请求源，（服务器没有获取到IP地址）</td></tr>
					<tr><td>10008</td><td>被禁止的IP</td></tr>
					<tr><td>10009</td><td>被禁止的KEY</td></tr>
					<tr><td>10011</td><td>当前IP请求超过限制</td></tr>
					<tr><td>10012</td><td>当前Key请求超过限制</td></tr>
					<tr><td>10013</td><td>测试KEY超过请求限制</td></tr>
					<tr><td>10020</td><td>接口维护</td></tr>
					<tr><td>10021</td><td>接口停用</td></tr>
					<tr><td>10022</td><td>appKey按需剩余请求次数为零</td></tr>
					<tr><td>10023</td><td>请求IP无效</td></tr>
					<tr><td>10024</td><td>网络错误</td></tr>
					<tr><td>10025</td><td>没有查询到结果</td></tr>
					<tr><td>10026</td><td>当前请求频率过高超过权限限制</td></tr>
					<tr><td>10027</td><td>账号违规被冻结</td></tr>
				</table>
			</div>
			<div id="tab5" class="tab-pane">
				<textarea class="input ued_openapi_txtatea" disabled style="font-size:15px">${(api.apiSample)!""}</textarea>
			</div>
	    </div>
	</div>
</div>
<div class="modal fade bs-example-modal-md" id="orderPrompt" role="dialog" aria-label="myBuylabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content" style="margin-top:80px">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="close">
					<span aria-hidden="true">&times;</span>
		        </button>
		        <h4 class="modal-title" style="font-size: 22px;">提示</h4>
			</div>
			<div class="modal-body" style="text-align: center;font-size: 40px;"></div>		
			<div class="modal-footer">
	        	<button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>