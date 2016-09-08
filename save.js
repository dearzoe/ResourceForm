/**
 * Created by U10K on 2016/9/7.
 */
var clsId=eaf.getUrlParam('clsid');
resFormObj.EAF_RESOURCEID=$('#dgd_Attrs').datagrid('getChecked')[0].EAF_RESOURCEID;
eaf.getIframWin(top.window.frames["ifmbimcenter"].document.getElementById(""+clsId)).data.push(data);
data={};
eaf.getIframWin(top.window.frames["ifmbimcenter"].document.getElementById(""+clsId)).deleteObjects.push(deleteObjects);
deleteObjects={};


var data=[];
var deleteObjects=[];
if(data){
    eaf.saveData('ObjectService', 'SaveObjects', data, '');
    data=[];
}
if(deleteObjects){
    eaf.saveObjects(resClsId, [], [], deleteObjects, function (arg) {
        alert("删除成功");
    });
    deleteObjects=[];
}


var data={

}
eaf.saveData('ObjectService', 'SaveObjects', data, '');


/*save*/
//$('#uie_dgd_objectlist').datagrid('getSelected').EAF_RESOURCEID;