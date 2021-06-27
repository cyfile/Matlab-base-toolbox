%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-8 text2struct.m
function [out,info] = text2struct(fid)
%function [out,info] = text2struct(fid)
isclose = 0;
if ischar(fid)
    fid = fopen(fid,'r');
end
 
out = [];
name = fscanf(fid,'%s',1);
cls = fscanf(fid,'%s',1);
nfields = fscanf(fid,'%d',1);
fm = cell(nfields,1);
for kk = 1:nfields
    fm{kk} = fscanf(fid,'%s',1);
end
 
out = struct;
for kk = 1:nfields
    tout = text2numberic(fid);    
    out.(fm{kk}) = tout.data;
end
 
info.name = name;
info.cls = cls;
info.nfields = nfields;

if isclose
    fclose(fid);
end
