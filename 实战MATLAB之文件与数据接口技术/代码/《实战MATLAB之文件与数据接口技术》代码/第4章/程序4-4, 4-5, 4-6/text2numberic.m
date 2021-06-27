%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-6 text2numberic.m
function [out] = text2numberic(fid)
%function [out] = text2numberic(fid)
isclose = 0;
if ischar(fid);
    fid = fopen(fid,'r');
    isclose = 1;
end
out = [];
%读取变量名称和类型
name = fscanf(fid,'%s',1);
cls = fscanf(fid,'%s',1);
dims = fscanf(fid,'%d',1);
sz = fscanf(fid,'%d',dims);sz = reshape(sz,1,length(sz(:)));
formatstr = getformatstr(cls);
if isequal(formatstr,'unknown')
    %对于其他数值类型统一采用浮点型处理
    formatstr = '%f';
end
if ~isequal(cls,class('sss'))%方便对字符型数据进行处理
    formatstr = [formatstr ','];
end
data = fscanf(fid,formatstr,prod(sz));
if isclose
    fclose(fid);
end
out.name = name;
out.cls = cls;
out.data = reshape(data,int32(sz));
