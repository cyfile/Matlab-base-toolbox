%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 6-5 color2num.m
function [out] = color2num(in)
r = in(3);g = in(2);b = in(1);
r = uint8(r*255);
g = uint8(g*255);
b = uint8(b*255);
r = dec2hex(r,2);
g = dec2hex(g,2);
b = dec2hex(b,2);
color = [r g b];
disp(color);
out = hex2dec(color);
end % end of color2num.m