%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-7 testrepmat.m
% 保存为testrepmat.m文件
% 运用repmat函数
% 绘制sin(x)*sin(y)的三维曲面图

%首先清空workspace的变量
clear all;
clc;
x = -pi:0.01:pi;
y = -pi:0.01:pi;
y = y';
x1 = repmat(x,length(x),1);
y1 = repmat(y,1,length(y));
z = sin(x1)+sin(y1);
mesh(x1,y1,z);
xlabel('x');
ylabel('y');
zlabel('z');
title('sin(x)+sin(y)');
