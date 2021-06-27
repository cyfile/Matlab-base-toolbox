%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-7 struct2text.m
function [out] = struct2text(fid,in,name)
%function [out] = struct2text(fid,in,name)
isclose = 0;
if ischar(fid)
    fid = fopen(fid,'w');
end

out = 0;
if ~isstruct(in)
    return;
end
in = in(1);%只处理单个结构体
%写入结构体一般信息，包括：
%名称，类型，域个数，各域域名
names = fieldnames(in);
fprintf(fid,'%s %s %d\n',name,class(in),length(names(:)));
for kk = 1:length(names(:))
    fprintf(fid,'%s\n',names{kk});
end
%写入结构体域的数据信息
for kk = 1:length(names(:))
    fd = in.(names{kk});
    numberic2text(fid,fd,names{kk});
end

if isclose
    fclose(fid);
end
