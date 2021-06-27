%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-4 getformatstr.m
function [outstr] = getformatstr(dataclass)
%function [outstr] = getformatstr(dataclass)
outstr = [];
formatstr = {'int', '%d'; 'single', '%g'; 'double', '%g'; 'char', '%s'};

for kk = 1:size(formatstr,1)
    str = formatstr{kk,1};
    if strfind(dataclass,str)
       outstr = formatstr{kk,2};
    end
end
if isempty(outstr)
    outstr = 'unknown';
end
