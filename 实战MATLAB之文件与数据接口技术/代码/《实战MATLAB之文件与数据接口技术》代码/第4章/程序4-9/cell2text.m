%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-9 cell2text.m
function [] = cell2text(fid,data)
% 本函数将cell阵列写入到txt文件中，处理的cell阵列满足如下要求：
% 1. cell阵列各元组的数据类型为基本类型，即不能嵌套包含结构体或元组
% 2. cell阵列为2维

if ischar(fid)
    fid = fopen(fid,'w');
end
if ~iscell(data)
    disp('待处理数据不是cell阵列');
    return;
end
if length(size(data))>2
    disp('待处理cell阵列维数大于2.');
    return;
end
datainfo = whos('data');
for ii = 1:datainfo.size(1)
    for jj = 1:datainfo.size(2)
        datatemp = data{ii,jj};
        tempinfo = whos('datatemp');
        fprintf(fid,'cell{ %d,%d }\n',ii,jj);
        fprintf(fid,'class : %s ; size : %d %d\n',...
            tempinfo.class,tempinfo.size(1),tempinfo.size(2));
        if isnumeric(datatemp)
            datatemp = num2str(datatemp);
        end
        for kk = 1:size(datatemp,1)
            fprintf(fid,'%s\n',datatemp(kk,:));
        end
    end
end
end
