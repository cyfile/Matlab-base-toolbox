%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 2-12 teststring.m
%保存为teststring.m文件
function []=teststring()
%function []=teststring()
%teststring.m
%MATLAB 字符操作函数
%mat2str函数生成eval可以执行的字符串
data = rand(3,3);
sdata = mat2str(data);
eval(sdata);

%掷硬币的游戏，如果is是'1'则为正面，否则为反面
%字符串比较
%字符和数字之间的转换
str = '1';
is = num2str(round(rand));
if strcmp(str,is)
    disp('硬币的正面');
else
    disp('硬币的反面');
end

%输出26个字母的ASCII码值
strLetter = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
valLetter = double(strLetter);
disp(valLetter);
