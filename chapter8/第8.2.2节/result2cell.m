%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [outc] = result2cell(r,schar)
%function [outc] = result2cell(r,schar)
%r表示外部命令执行结果字符串
%schar表示拟采用的分割符号默认采用ASCII字符10，即换行符
if nargin==1
    schar = 10;
end
ind = find(r==schar);
nn = length(ind(:));
outc = cell(nn,1);
ib = 1;
for kk = 1:nn
    ie = ind(kk);
    outc{kk} = r(ib:(ie-1));
    ib = ie+1;
end
