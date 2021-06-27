%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 4-1 CmpDlmreadAndImportdata.m
N = 25;
tic
for ii=1:N
    data1 = dlmread('data.txt');
end
toc
tic
for ii=1:N
    data2 = importdata('data.txt');
end
toc
