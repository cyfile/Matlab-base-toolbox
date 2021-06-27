%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 8-3 addDoubleS.m
function [out] = addDoubleS(in1,in2)
if ~libisloaded('dlladd')
    loadlibrary('dlladd');
end
out = calllib('dlladd','addDoubleS',in1,in2);
