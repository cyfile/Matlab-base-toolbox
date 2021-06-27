%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-6 testfor.m
% testfor.m
%清空workspace的变量
clear all;
clc;
%MATLAB循环语句与向量运算的测试语句。
N = 1e7;
a = 1:N;
b =N:-1:1;
 
tic,%计时开始
sum_axb1=zeros(1,N) ;
for i=1:N
    sum_axb1(i)=  a(i)*b(i);
end;
time1=toc;%计时结束并输出采用循环语句进行运算的时间
tic,%计时开始
sum_axb2=a.*b;
time2=toc;%计时结束并输出采用向量运算消耗的时间
result1= strcat('采用循环语句运算消耗的时间为:',num2str(time1),'秒');
result2= strcat('采用向量运算消耗的时间为:',num2str(time2),'秒');
disp(result1);
disp(result2);
