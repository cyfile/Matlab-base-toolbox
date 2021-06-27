%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-11 processgrayimage.m
%保存为processgrayimage.m文件
function []=processgrayimage()
%function []=processgrayimage()
%processgrayimage.m
%说明:
%     MATLAB读取的位图图像数据是8位无符号整型
%     MATLAB显示和存储图像的时候，也需要是8位无符号整型
%     或者将所有的数据归一到[0 1]之间
%     因而采用double和uint8进行整型和双精度型之间的转换就比较方便
[name,path] = uigetfile({'*.bmp', '请选择一个位图文件(*.bmp)'},'请打开一个位图文件');
file = strcat(path,name);
[I,map]=imread(file);
if size(I,3)==3
    I = rgb2gray(I);    
end
%将图像数据转换为double型数据以方便处理
I = double(I);
I1 = I - 100;
signI1 = sign(I1);
coefI1 = (signI1 + abs(signI1))/2;
%大于100的图像部分
I1 = I.*coefI1;
%小于100的图像部分
I2 = I.*(1-coefI1);
I1 = (I1/max(max(I1)))*255;
I2 = (I2/max(max(I2)))*255;
%将数据转换为unsigned int8型数据，以方便进行显示
I1 = uint8(I1);
I2 = uint8(I2);
figure;
h1=subplot(1,2,1);
subimage(I1);
h2=subplot(1,2,2);
subimage(I2);
truesize;
