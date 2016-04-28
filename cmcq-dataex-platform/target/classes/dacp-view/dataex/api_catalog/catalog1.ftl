<html class=" js no-touch rgba opacity svg" style="" lang="zh-cn">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=Edge">
<title>API目录</title>
<!-- Core Meta -->
<meta name="viewport" content="initial-scale=1.0,width=device-width,user-scalable=no">
<link rel="icon" href="${mvcPath}/dacp-res/images/dacp_favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="${mvcPath}/dacp-res/images/dacp_favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="${mvcPath}/dacp-res/dataex/css/homepage-one-field-long.css" type="text/css">
<link href="${mvcPath}/dacp-view/aijs/css/ai.css" type="text/css" rel="stylesheet" />
<style>
.api-content-head {
	margin: 0 0 15px 0;
}

.api-content-head .left {
	float: left;
}

.api-content-head li {
	float: left;
	font-size: 16px;
	padding: 3px;
}

.api-content-head li a {
	color: #999;
}

.api-content-head .active, .api-content-head li:hover, .api-content-head .active a,
	.api-content-head a:hover {
	color: #4CB6CB;
	font-weight: bolder;
}

.api-content-head .border {
	border: 1px solid;
}

.api-content-head .no-left-border {
	border-top: 1px solid;
	border-right: 1px solid;
	border-bottom: 1px solid;
}

.api-content-head .right {
	float: right;
}

.api-content-head input {
	height: 30px;
	width: 200px;
}

.api-content-head button {
	margin-top: -3px;
	margin-left: -47px;
}

a.list-group-item {
	text-indent: 36px;
}

.con-attr {
	padding: 0px;
	border: 0px solid #ddd;
}

.con-attr h4 {
	font-size: 18px;
	line-height: 24px;
}

.con-attr p {
	line-height: 24px;
}

.con-attr-pic {
	width: 210px;
	height: 140px;
	background-color: #F7C9C9;
	text-align: center;
	margin-bottom: 10px;
}
.listline>li>.listline-item {
  -webkit-box-shadow: 0 1px 1px rgba(0,0,0,0.1);
  box-shadow: 0 1px 1px rgba(0,0,0,0.1);
  border-radius: 3px;
  margin-top: 0;
  background: #fff;
  color: #444;
  padding: 0;
  position: relative;
  margin: 10px 0;
  border: 1px solid #f4f4f4;
}

.listline>li>.listline-item>.time {
  color: #999;
  float: right;
  padding: 10px;
  font-size: 12px;
}
.listline>li>.listline-item>.listline-header {
  margin: 0;
  color: #555;
  border-bottom: 1px solid #f4f4f4;
  padding: 10px;
  font-size: 16px;
  line-height: 1.1;
}
.listline>li>.listline-item>.listline-body, .listline>li>.listline-item>.listline-footer {
  padding: 10px;
  color: #555;
}

.list-group-item{cursor:pointer;}
.list-group-item.catalog-list.active, .list-group-item.catalog-list.active:hover, .list-group-item.catalog-list.active:focus {
  z-index: 2;
  color: #fff;
  background-color: #3199f4 !important;
  border-color: #3199f4 !important;
}
.list-group-item.catalog-list .list-label{
  float: left;
  margin: 0 -20px;
}
</style>
	<script type="text/javascript" src="${mvcPath}/dacp-lib/jquery/jquery-1.10.2.min.js"></script>
	<script src="${mvcPath}/dacp-lib/cryptojs/aes.js" type="text/javascript"></script>
	<script src="${mvcPath}/crypto/crypto-context.js" type="text/javascript"></script>
	<script type="text/javascript" src="${mvcPath}/dacp-lib/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${mvcPath}/dacp-lib/underscore/underscore-min.js"></script>
	<script src="${mvcPath}/dacp-lib/jquery-plugins/jquery.form.js"></script>
	<script src="${mvcPath}/dacp-lib/bootstrap/js/bootstrap-paginator.js"></script>
	<script src="${mvcPath}/dacp-lib/jquery-plugins/jquery.cookies.2.2.0.min.js"></script>
	<script src="${mvcPath}/dacp-view/aijs/js/ai.core.js"></script>
	<script src="${mvcPath}/dacp-view/aijs/js/ai.field.js"></script>
	<script src="${mvcPath}/dacp-view/aijs/js/ai.jsonstore.js"></script>

	<script src="${mvcPath}/dacp-view/aijs/js/ai.grid.js"></script>
	
	<script>
		$(document).ready(function(){
			var url = '${mvcPath}/dataex/api_catalog?category={category}&apiName={apiName}&sortColumn={sortColumn}&desc={desc}';
			var category = "${category!'全部'}";
			var apiName = "${apiName!''}";
			$("#searchText").val(apiName);
			if($.cookies.get('sortColumn')==null){
				$.cookies.set('sortColumn', 'createDt');			
			}
			$("#categoryName a").removeClass("active");
			$("#categoryName a").each(function(i,e){
				if(e.name == category){
					$(this).addClass("active");
				}
			});
			if($.cookies.get('sortColumn')!=$("#sortColumn .active").attr("name")){
				$("#sortColumn li span").attr("class","glyphicon glyphicon-sort");
				$("#sortColumn li").attr("class","");
				$("li[name='"+$.cookies.get('sortColumn')+"']").attr("class","active");
			}
			if($.cookies.get('sortDesc')=="desc"){
				$($("#sortColumn .active").find("span")[0]).attr("class","glyphicon glyphicon-sort-by-attributes-alt");				
			}else if($.cookies.get('sortDesc')=="asc"){
				$($("#sortColumn .active").find("span")[0]).attr("class","glyphicon glyphicon-sort-by-attributes");
			}else{				
				$($("#sortColumn .active").find("span")[0]).attr("class","glyphicon glyphicon-sort");				
			}
			$("#categoryName a").click(function(){
				category = this.name;
				refreshPage(paraReplace(url,category,apiName));
			});
			$("#searchBtn").click(function(){
				apiName = $("#searchText").val();
				refreshPage(paraReplace(url,category,apiName));
			});
			
			$("#dialog-ok").click(function(){
				$.ajax({type:"POST", 
					url:'${mvcPath}/dataex/authPrivage', 
					async:false, 
					data:$('#frm').serialize(),
					error: function(req, status, error) {
						$(".modal-body").html("保存失败!"+req+status+error).css("color","red");
					},
					success:function (data) {
						if(data.code=='0000'){
							$("#dialog-ok").prop("disabled",true);
							$(".modal-body").html("保存成功!").css("color","green");
							$("#cancelBtn"+$("#apiId").val()).removeClass("hidden");
							$("#orderBtn"+$("#apiId").val()).addClass("hidden");
						}else{
							$(".modal-body").html("保存失败!").css("color","red");
						}
					}});
			});
			
			$("#sortColumn li").click(function(){
				var sortColumn = $.cookies.get('sortColumn');
				var clickColumn = $(this).attr("name");
				var desc = "desc";
				if(clickColumn == sortColumn){
					var classs = $($(this).find("span")[0]).attr("class");
					if(classs.endsWith("-sort")){
						$($(this).find("span")[0]).attr("class","glyphicon glyphicon-sort-by-attributes");
						desc = "asc";
					}else if(classs.endsWith("-attributes")){
						$($(this).find("span")[0]).attr("class","glyphicon glyphicon-sort-by-attributes-alt");
						desc = "desc";
					}else{
						$($(this).find("span")[0]).attr("class","glyphicon glyphicon-sort");
						desc = "";
					}
					$.cookies.set('sortDesc',desc);
				}else{
					$("#sortColumn li span").attr("class","glyphicon glyphicon-sort");
					$("#sortColumn li").removeClass("active");
					$(this).addClass("active");
					$($(this).find("span")[0]).attr("class","glyphicon glyphicon-sort-by-attributes-alt");
					$.cookies.set('sortColumn',clickColumn);
				}
				refreshPage(paraReplace(url,category,apiName,clickColumn,desc));
			});
			function loadPage(pageNum,pageSize){
				refreshPage(paraReplace(url,category,apiName)+'&pageNum='+pageNum+'&pageSize='+pageSize);
			}
			function paraReplace(url,category,apiName,sortColumn,desc){
				if(category=='全部'){
					category = '';
				}
				url = url.replace(/\{category\}/ig,category||'');
				url = url.replace(/\{apiName\}/ig,apiName||'');
				url = url.replace(/\{sortColumn\}/ig,sortColumn||'');
				url = url.replace(/\{desc\}/ig,desc||'');
				return url;
			}
			function refreshPage(url){
				window.location.href = url;
			}
		});
		
		
		function openDialog(apiId){
			$("#apiId").val(apiId);
			$.ajax({type:"get", 
				url:'${mvcPath}/dataex/getPrivage?apiId='+apiId, 
				async:false, 
				error: function(req, status, error) {
					 alert(error);
				},
				success:function (data) {
					if(data.code=='0000'){
		                $("#staffModal input[type='checkbox']").each(function () {
		                    if (data.result.indexOf($(this).val())>=0) {
		                    	$(this).prop("checked",true);
		                    }else{
		                    	$(this).prop("checked",false);
		                    }
		                })
					}else{
						$(".modal-body").html("初始化失败!").css("color","red");
					}
					$("#staffModal").modal("show");
				}});
		}
		
		function openDialog2(apiId){
			if(confirm("您确定确定取消申请授权吗?")){
				$.ajax({type:"GET", 
					url:'${mvcPath}/dataex/unauthPrivage?apiId='+apiId, 
					async:false, 
					error: function(req, status, error) {
						alert("保存失败!");
					},
					success:function (data) {
						if(data.code=='0000'){
							alert("保存成功!");
							$("#orderBtn"+apiId).removeClass("hidden");
							$("#cancelBtn"+apiId).addClass("hidden");

						}else{
							alert("保存失败!");
						}
					}});
			}
		}
	</script>
</head>
<body class="zh-cn" style="background-color: white;">
	<#assign menuName = "apiCatalog" />
	<div class="container">
		<div class="row" style="margin-top: 30px;">
			<div class="col-md-2">
				<div id="categoryName" class="tab-content">
					<div class="tab-pane list-group active" id="apiType">
						<a name="全部" class="list-group-item img-all catalog-list active"> 
							<span class="glyphicon glyphicon-align-justify list-label"></span> 全部 
						</a>
						<#if categories??>
						<#list categories as category> 
							<a name="${category}" class="list-group-item img-api catalog-list"> 
								<span class="glyphicon glyphicon-paperclip list-label" ></span> <#if category='110'>金融类<#elseif category='120'>广告类<#elseif category='130'>营销类   <#elseif category='140'>旅游类<#elseif category='200'>功能类<#elseif category='900'>其他类<#else>${category}</#if>
							</a> 
						</#list>
						</#if>
					</div>
				</div>
			</div>
			<div class="col-md-10">
				<div class="row api-content-head">
					<div class="input-group left" style="width: 300px">
						<input type="text" id="searchText" class="form-control"
							placeholder="搜索名称" style="margin-top: -3px"
							value="${apiName!''}"> <span class="input-group-btn">
							<button class="btn" id="searchBtn" type="button"
								style="height: 30px;background-color: #3199f4;border-color: #3199f4;color: #fff;">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</span>
					</div>
					<div class="right">
						<ul class="left" id="sortColumn">
							<!--<li name="saleCount"><div style="margin-right:10px;cursor:pointer;">销量<span class="glyphicon glyphicon glyphicon-sort"></span></div></li>
				      		-->
							<li class="active" name="updateTime"><div
									style="margin-right: 10px; cursor: pointer; color: #666; font-size: 12px;">
									上线时间<span class="glyphicon glyphicon glyphicon-sort"></span>
								</div></li>
						</ul>
					</div>
				</div>
				<ul id="list" class="tab-pane listline" name="list">
					<#list page.getContent() as apis>
					<li>
						<div class="listline-item">
							<span class="time">
								<#if permitString?contains(apis.apiId)>
									<a id="orderBtn${apis.apiId}" class="btn btn-success btn-xs hidden" onclick="openDialog('${apis.apiId}')">授权申请</a>
									<a id="cancelBtn${apis.apiId}" class="btn btn-danger btn-xs " onclick="openDialog2('${apis.apiId}')">撤销申请</a>
								<#else>
									<a id="orderBtn${apis.apiId}" class="btn btn-success btn-xs " onclick="openDialog('${apis.apiId}')">授权申请</a>
									<a id="cancelBtn${apis.apiId}" class="btn btn-danger btn-xs hidden" onclick="openDialog2('${apis.apiId}')">撤销申请</a>
								</#if>
							</span>
		                    <h3 class="listline-header">
		                    	<a href="${mvcPath}/dataex/apiDetail/${apis.apiId}" style="font-size:16px;font-weight: 700;line-height: 1.1;padding:5px 0;"> ${apis.apiLabel} </a> 
		                    	<div><small><#if apis.category?? && apis.category='110'>金融类<#elseif apis.category?? && apis.category='120'>广告类<#elseif apis.category?? && apis.category='130'>营销类<#elseif apis.category?? && apis.category='140'>旅游类<#elseif apis.category?? && apis.category='200'>功能类<#elseif apis.category?? && apis.category='900'>其他类<#else>${(apis.category)!''}</#if> </a> </small></div> 
		                    	<div><small><i class="fa fa-clock-o"></i> ${apis.createDt!'未知时间'} </small></div> 
		                    </h3>
		                    <div class="listline-body" style="padding:10px;">
		                      ${apis.descr!'暂无'}
		                    </div>
		             	</div>
		            </li>
		             </#list>

				</ul>
					<#if (page.getTotalPages()=0)>
					<div style="text-align: center; font-size: 40px; margin-top: 80px;">暂无数据</div>
					<#else> <#include "../page.ftl" parse=true/> </#if>
				</div>
			</div>
		</div>

		<div id="staffModal" class="modal fade">
			<form id="frm"  method="post" action="/dataex/savePrivage"> 
			<input type="hidden" id="apiId" name="apiId" value="" />
			<div class="modal-dialog" style="top: 100px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h2 style="font-size: 18px;">授权申请(请选择你的APP申请授权)</h2>
					</div>
					<div class="modal-body" id="staffForm">
						<#list dacpAppList as apps>
						 <label>
               				<input id="${apps.appKey}" name="appKeys" type="checkbox" value="${apps.appKey}"> ${apps.appLabel} &nbsp;&nbsp;
            			 </label>
						</#list>
					</div>
					<div class="modal-footer">
					    <button id="dialog-cancel" type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
						<button id="dialog-ok" type="button" class="btn btn-primary">保 存</button>
					</div>					
				</div>
				<!-- /.modal-content -->
			</div>
			</form>
		</div>
</body>
</html>
