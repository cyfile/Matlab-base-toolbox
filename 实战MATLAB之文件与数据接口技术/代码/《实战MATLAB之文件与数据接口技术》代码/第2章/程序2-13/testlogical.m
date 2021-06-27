%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-13 testlogical.m
%保存为testlogical.m文件
clear all;
theta = -pi:0.1:pi;
a = sin(3*theta);%生成测试数据
%创建逻辑变量索引，flag与a大小相同，
%如果a(i)>0，则flag(i) = true
%如果a(i)<=0，则flag(i) = false;
flag = a > 0;
%获取变量a大于零的部分
a1(flag) = a(flag);
plot(theta/pi,a1, 'o','linewidth',2);
hold on;
plot(theta/pi,a,':','linewidth',2);
hold off;
xlabel('弧度(\pi)');
