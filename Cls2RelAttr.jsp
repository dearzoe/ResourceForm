<%@ include file='/main/head.jsp' %>
<script src="<%=eafapppath %>/main/UserInterface/control.js" type="text/javascript"></script>
<script src="<%=eafapppath %>/main/UserInterface/datagrid.js" type="text/javascript"></script>
<div data-options="region: 'center',title: ''" style="padding: 1px;">
    <table id="uie_dgd_objectlist">
    </table>
</div>
<script type="text/javascript">
    //创建保存数组
    var data;
    //创建删除数组
    var deleteObjects;
    //类id
    var clsid = '';
    //表格控件id
    var uiid = '';
    var eafdatagrid;
    var objectlist = $('#uie_dgd_objectlist');
    // 缓存原始数据
    var dataCache;
    var fromclassid='';
    $(function () {
        clsid = eaf.getUrlParam('clsid');
        uiid = eaf.getUrlParam('uiid');
        fromclassid=eaf.getUrlParam('fromclsid');
        //加载数据选项
        var opt = {};
        //获取属性列表
        var attrs = ctl.getAttrExByCls(clsid);
        //替换资源列
        eaf.findArray(attrs, "EAF_CNAME", "EAF_RESOURCEID").EAF_CNAME = 'EAF_EXISTRES';
        //显示属性ID
        var eaf_id = eaf.findArray(attrs, "EAF_CNAME", "EAF_ID");
        eaf_id.EAF_GRIDSHOW = 'Y';
        eaf_id.EAF_NOEDIT = 'Y';
        eaf_id.EAF_CTLTYPE = 'noedit';
        eaf_id.EAF_WIDTH = 200;
        attrs.push(eaf_id);
        eaf.delArray(attrs, 'EAF_CNAME', 'EAF_ID');
        var columns = ctl.getDataGridColumns(eaf.copyJson(attrs));
        //获取操作列表
        var tools = ctl.getGridOpersByCls(clsid, uiid);
        tools = ctl.getDataGridToos(tools);
        //创建辅助方法类
        eafdatagrid = new eaf_datagrid(objectlist, false, columns, tools);
        //获取datagrid的默认属性
        var opt = eafdatagrid.getopt(opt);
        opt.singleSelect = true;
        var frompclsid = eaf.getUrlParam('frompclsid');
        if (frompclsid) {
            opt.queryParams = { clsid: frompclsid };
        }
        var datagrid = objectlist.datagrid(opt);
        objectlist.datagrid({
        	onLoadSuccess:function(data){
        		dataCache=$.extend(true, [], data.rows);
        	}       	
        });
        //创建查询表单
        if (eafdatagrid.getGridConfig() && eafdatagrid.getGridConfig().EAF_ISSEARCH == "Y") { }
        else
            var searchpanel = ctl.createSearchForm(objectlist, attrs);

        //增加树配置
        //$('.datagrid-toolbar table tr').append('<td><input type="checkbox" value="Y">树配置</td>');
    });
    //列表单击事件
    function uie_dgd_onClickRow(rowIndex, rowData) {
        eafdatagrid.uie_dgd_onClickRow(rowIndex, rowData);
    }
    //选择列事件
    function uie_dgd_onCheck(rowIndex, rowData) {
    }
    //列表双击事件
    function uie_dgd_onDbClickRow(rowIndex, rowData) {
        eafdatagrid.uie_dgd_onDbClickRow(rowIndex, rowData);
    }
    //添加新数据事件
    function uie_dgd_append() {
        var adddata = {};
        adddata.EAF_RESOURCEID = eaf.guid();
        eafdatagrid.uie_dgd_append(adddata);
    }
    //删除行事件
    function uie_dgd_removeit() {
        eafdatagrid.uie_dgd_removeit();
    }
    //打开对象
    function uie_dgd_open() {
        //                var selrow = $(objectlist).datagrid('getSelected');
        //                window.open(eaf.getEafAppPath()+'/uicfg.jsp?uiid=03128627BC074D1C89FB1C88C7157C0D&clsid=' + clsid + '&objid=' + selrow.EAF_ID);
        eafdatagrid.uie_dgd_open();
    }
    //保存列表数据
    function uie_dgd_save() {    	
        eafdatagrid.uie_dgd_save();
    }
    //查询
    function uie_dgd_search() {
        eafdatagrid.uie_dgd_search();
    }
    //返回选择行数据
    function getResult() {
        return eafdatagrid.getSelected(true);
    };
    //返回所有数据
    function getSaveJson() {
        return eafdatagrid.uie_dgd_getsavejson();
    };
    //属性覆盖
    function uie_dgd_attrOverride(){
    	var adddata = {};
    	//获取选中行
    	var seldata=eafdatagrid.getSelected(false);
    	if(seldata!=null){
    		for (var item in seldata) {
                adddata[item] = seldata[item];
            }
    		//赋值新的资源id、父属性id、类id改为当前类id，去掉属性id
        	adddata.EAF_RESOURCEID = eaf.guid();
        	adddata.EAF_PATTRID=adddata.EAF_ID;
        	adddata.EAF_CLASSID=fromclassid;
        	delete adddata.EAF_ID;
        	eafdatagrid.uie_dgd_append(adddata);
    	}else{
    		$.messager.alert(eaf.getLabel('eaf_common_cue'), eaf.getLabel('eaf_common_selectRow'));
    	}   	
    };
</script>
<%@ include file='/main/footer.jsp' %>
