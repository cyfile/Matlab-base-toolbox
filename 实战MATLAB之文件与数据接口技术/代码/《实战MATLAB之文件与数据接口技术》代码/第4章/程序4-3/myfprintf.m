%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-3 myfprintf.m
function [str]=myfprintf(varargin)
%function [str]=myfprintf(varargin)

%测试MATLAB fprintf函数
filename = 'myfprintf.txt';

%构造命令字符串
nn = length(varargin(:));
cmdstr = 'fprintf(fid,';
for kk = 1:nn
    cmdstr = strcat(cmdstr,'varargin{',num2str(kk),'},');
end
cmdstr(end) = ')';
cmdstr(end+1) = ';';

%执行输入命令
fid = fopen(filename,'w');
eval(cmdstr);
fclose(fid);
 
%输出执行结果
str = fileread(filename);
