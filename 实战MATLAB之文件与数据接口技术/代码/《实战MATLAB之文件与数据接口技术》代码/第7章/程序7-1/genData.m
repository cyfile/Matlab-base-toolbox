%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 7-1 genData.m
function genData(filename,in)
%function genData(filename,in)
if iscell(in)
else
    in = {in};
end
nlen = length(in(:));
fid = fopen(filename,'wb');
for kk = 1:nlen
    td = in{kk};
    fwrite(fid,td(:),class(in{kk}));
end
fclose(fid);
end
