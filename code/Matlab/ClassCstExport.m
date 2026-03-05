classdef ClassCstExport < handle
    
    properties
        filePath;% CST文件目录+文件名
        savePath;% 数据导出存放目录
    end
    
    
    methods
        function Obj = ClassCstExport(filePath,savePath)
            Obj.filePath = filePath;
            Obj.savePath = savePath;
        end
        
        
        function SParameter(Obj)
            filePath   = Obj.filePath;
            exportPath = Obj.savePath;
            if ~exist(exportPath,'dir')% 导出数据存放目录，如不存在，创建目录
                mkdir(exportPath);
            end
            
            ComCst = actxserver('CSTStudio.application');
            mws = invoke(ComCst,'OpenFile', filePath);% 打开一个MWS项目
            
            % 读取端口设置，并自动判断输入端口
            selectTreeItem = invoke(mws,'SelectTreeItem',['1D Results\S-Parameters\',['SZmax(1),Zmax(1)']]);
            
            if selectTreeItem == 1% 如果存在'SZmax(1),Zmax(1)'，输入端口为Zmax
                % max为输入端口
                str_S11_TE_TE = ['SZmax(1),Zmax(1)'];
                str_S21_TE_TE = ['SZmin(1),Zmax(1)'];
                str_S11_TM_TM = ['SZmax(2),Zmax(2)'];
                str_S21_TM_TM = ['SZmin(2),Zmax(2)'];
                lable_S11_TE_TE = 'S11_TE';
                lable_S21_TE_TE = 'S21_TE';
                lable_S11_TM_TM = 'S11_TM';
                lable_S21_TM_TM = 'S21_TM';
                exportPathname_S11_TE_TE = [exportPath,'\',lable_S11_TE_TE,'.txt'];
                exportPathname_S21_TE_TE = [exportPath,'\',lable_S21_TE_TE,'.txt'];
                exportPathname_S11_TM_TM = [exportPath,'\',lable_S11_TM_TM,'.txt'];
                exportPathname_S21_TM_TM = [exportPath,'\',lable_S21_TM_TM,'.txt'];
                
                
                cstExportSpTxt(mws, str_S11_TE_TE, exportPathname_S11_TE_TE);
                cstExportSpTxt(mws, str_S21_TE_TE, exportPathname_S21_TE_TE);
                cstExportSpTxt(mws, str_S11_TM_TM, exportPathname_S11_TM_TM);
                cstExportSpTxt(mws, str_S21_TM_TM, exportPathname_S21_TM_TM);
                
                winopen(exportPath);% 数据存储完成后，打开其存放的目录
            elseif selectTreeItem == 0 % 否则，输入端口为Zmin
                % min为输入端口
                str_S11_TE_TE = ['SZmin(1),Zmin(1)'];
                str_S21_TE_TE = ['SZmax(1),Zmin(1)'];
                str_S11_TM_TM = ['SZmin(2),Zmin(2)'];
                str_S21_TM_TM = ['SZmax(2),Zmin(2)'];
                lable_S11_TE_TE = 'S11_TE';
                lable_S21_TE_TE = 'S21_TE';
                lable_S11_TM_TM = 'S11_TM';
                lable_S21_TM_TM = 'S21_TM';
                exportPathname_S11_TE_TE = [exportPath,'\',lable_S11_TE_TE,'.txt'];
                exportPathname_S21_TE_TE = [exportPath,'\',lable_S21_TE_TE,'.txt'];
                exportPathname_S11_TM_TM = [exportPath,'\',lable_S11_TM_TM,'.txt'];
                exportPathname_S21_TM_TM = [exportPath,'\',lable_S21_TM_TM,'.txt'];
                
                
                cstExportSpTxt(mws, str_S11_TE_TE, exportPathname_S11_TE_TE);
                cstExportSpTxt(mws, str_S21_TE_TE, exportPathname_S21_TE_TE);
                cstExportSpTxt(mws, str_S11_TM_TM, exportPathname_S11_TM_TM);
                cstExportSpTxt(mws, str_S21_TM_TM, exportPathname_S21_TM_TM);
                winopen(exportPath);% 数据存储完成后，打开其存放的目录
            end
            
        end
    end
end