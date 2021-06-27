%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-17 testimage.m
%保存为testimage.m文件
out = load('trees');
img = out.X;
map = out.map;
clear out;
xdata = [0 30];
ydata = [0 10];
imagesc(img,'xdata',xdata,'ydata',ydata);
colormap(map);
xlabel('x轴(米)');
ylabel('y轴(米)');
