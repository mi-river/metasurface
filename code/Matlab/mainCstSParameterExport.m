clc
clear
close all


%%
[fileName,filePathName] = uigetfile('*.cst','选择需导出数据的模型');
pathNameOpenFile = [filePathName,fileName];

savePathDefault = [filePathName,fileName(1:end-4),'\',fileName(1:end-4)];% 默认保存路径
if ~exist(savePathDefault,'dir')
    mkdir(savePathDefault)
end
[savePathByUser] = uigetdir(savePathDefault,'当前为默认的保存路径，可更改');% 用户更改后的保存路径


CSTExport = ClassCstExport(pathNameOpenFile,savePathByUser);
CSTExport.SParameter;