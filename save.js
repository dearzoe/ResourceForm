/**
 * Created by U10K on 2016/9/7.
 */
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