<!DOCTYPE html>
<html lang="zh" class="app">
<head>
<meta charset="utf-8" />
<title>元数据同步</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="${mvcPath}/dacp-view/aijs/css/ai.css" type="text/css" />
<link rel="stylesheet" href="${mvcPath}/dacp-res/dataex/css/open.css" type="text/css" />

<script type="text/javascript" src="${mvcPath}/dacp-lib/jquery/jquery-1.10.2.min.js"></script>
<script src="${mvcPath}/dacp-lib/cryptojs/aes.js" type="text/javascript"></script>
<script src="${mvcPath}/crypto/crypto-context.js" type="text/javascript"></script>
<script type="text/javascript" src="${mvcPath}/dacp-lib/bootstrap/js/bootstrap.min.js"></script>

<script src="${mvcPath}/dacp-view/aijs/js/ai.core.js"></script>
<script src="${mvcPath}/dacp-view/aijs/js/ai.field.js"></script>
<script src="${mvcPath}/dacp-view/aijs/js/ai.jsonstore.js"></script>
<script src="${mvcPath}/dacp-view/aijs/js/ai.grid.js"></script>

<script type="text/javascript" src="${mvcPath}/dacp-lib/underscore/underscore-min.js"></script>
<style>
</style>
<script>
$(document).ready(function() {

   var apiSql="SELECT a.api_id,a.api_label,a.create_dt,a.create_user,(select enum_value from dacp_dataex_enum where enum_code='API_CATEGORY' and enum_key = a.category) category,b.sync_state,b.sync_dt,b.remark FROM dacp_dataex_api a,dacp_dataex_api_sync b WHERE a.api_id = b.api_id";
   var ds_mydata= new AI.JsonStore({///团队成员表
		sql :apiSql,
		table:'DACP_DATAEX_API_SYNC',
		key:'API_ID',
		pageSize : 50
	});
	
   var apiHisSql="select * from dacp_dataex_api_sync_his ";
   var apiHis_data= new AI.JsonStore({///团队成员表
		sql :apiHisSql,
		table:'DACP_DATAEX_API_SYNC_HIS',
		key:'API_ID',
		pageSize : 50
	});

    $("#tabpanel").empty();

    var config={
        bAutoWidth:true,
        store:ds_mydata,
        //pageSize:15,
        containerId:'tabpanel',
        nowrap:true,
        showcheck:true,
        columns:[
            {header: "API标识", width:20,dataIndex: 'API_ID', sortable: true},
            {header: "API名称", width:80,dataIndex: 'API_LABEL', sortable: true},
            {header: "创建时间", width:80,dataIndex: 'CREATE_DT', sortable: true},
            {header: "创建者", width:80,dataIndex: 'CREATE_USER', sortable: true},
            {header: "业务类型", width:40,dataIndex: 'CATEGORY', sortable: true},
            {header: "状态", width:80,dataIndex: 'SYNC_STATE', sortable: true},
            {header: "同步时间", width:80,dataIndex: 'SYNC_DT', sortable: true},
             {header: "备注", width:180,dataIndex: 'REMARK', sortable: true}
            ]
    };

    var grid =new AI.Grid(config);

    $("#search-table").click(function(){
        
        var apiId=($("#toolbar #apiId").val());
        if(apiId) apiSql += " and api_id like '%"+apiId+"%'";
        ds_mydata.select(apiSql);
        return false;
    });


    $("#syncAct").click(function(){
	   	 var selected = grid.getCheckedRows();
		 console.log(selected);
		 if(selected&&selected.length>0){
			 for(var i=0;i<selected.length;i++){
                if(selected[i].get("SYNC_STATE")=="已同步"){
			 		alert("选择项里存在已同步数据，请重新选择!");
				 	return false;
                }
	    	 }
		 }
		 if(selected&&selected.length>0&&confirm("确认同步勾选的 "+selected.length+" 项吗？")){	 	
			 for(var i=0;i<selected.length;i++){
				$.ajax({
			 		type:"GET", 
					url:'${mvcPath}/getApi/sync', 
					async:false, 
					data:"apiId="+selected[i].get("API_ID"),
					error: function(req, status, error) {
						alert("获取数据失败!");
					},success:function (resp) {
						if("同步成功"==resp){
							selected[i].set('SYNC_STATE','已同步');
							selected[i].set('REMARK',resp);							
						}else{
							selected[i].set('SYNC_STATE','失败');
							selected[i].set('REMARK',resp.substring(0,30));
						}
					}
				});
	    	 }
			 ds_mydata.commit();
			 ds_mydata.select();
		 }else if(selected.length==0){
			 alert("必须选中一条数据才能同步！")
		 }
		 return false;
    });
    $("#syncHistory").click(function(){
    	var selected = grid.getCheckedRows();
    	if(selected&&selected.length==1){
    		apiHis_data.select(apiHisSql+" where api_id = '"+selected[0].get("API_ID")+"'")
		    $("#hisApiPanel").empty();
		
		    var configHis={
		        bAutoWidth:true,
		        store:apiHis_data,
		        //pageSize:15,
		        containerId:'hisApiPanel',
		        nowrap:true,
		        columns:[
		            {header: "API标识", width:20,dataIndex: 'API_ID', sortable: true},
		            {header: "同步状态", width:80,dataIndex: 'SYNC_STATE', sortable: true},
		            {header: "同步时间", width:80,dataIndex: 'SYNC_DT', sortable: true},
		            {header: "备注", width:280,dataIndex: 'REMARK', sortable: true}
		            ]
		    };
		
		    new AI.Grid(configHis);
	    	$("#hisList").modal('show');
    	}else{
    		alert("请选择一条数据!");
    		return false;
    	}
    });

    $("#search-table").click();
});
</script>
</head>
<body class="" >
	 
    <section class="hbox stretch">

            <section class="vbox">

                <ul class="nav navbar-nav bg-light dk" style="width: 100%;height: 40px;" id="toolbar">
                    <li style="margin-top: 12px; margin-left: 1px; margin-right: 1px; border-left: 1px solid #ddd; height: 20px;"></li>
                    <li><p class="navbar-text" style="margin-top: 10px;"> API标识: <input id="apiId" type="text" style="width:120px"> </p></li>
                    <li><a id="search-table" href="#" style="float: left; margin-right: 0px">查找</a></li>
                    <li style="margin-top: 12px; margin-left: 1px; margin-right: 3px; border-left: 1px solid #ddd; height: 20px;"></li>
                    <li><a id="syncAct" href="#" style="float: left">同步操作</a></li>
                    <li><a id="syncHistory" href="#" style="float: left">同步历史</a></li>
                </ul>

                <div class="row row-sm" id="tabpanel"></div>

            </section>

    </section>

	<!-- Bootstrap -->
	<!-- App -->
 

	<div id="hisList" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">API的同步历史</h4>
				</div>
				<div class="modal-body" id="staffForm">
					<div class="row row-sm" id="hisApiPanel"></div>
				</div>
				<div class="modal-footer">
					<button id="dialog-cancel" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button id="dialog-ok" type="button" class="btn btn-primary" data-dismiss="modal">确认</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

</body>
</html>