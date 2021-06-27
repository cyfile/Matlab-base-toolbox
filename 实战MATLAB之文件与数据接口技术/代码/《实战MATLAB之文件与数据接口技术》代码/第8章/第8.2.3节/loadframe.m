%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [framedata] = loadframe(filename)
framedata = load(filename);
framedata = framedata.framedata;
for kk = 1:length(framedata(:))
    framedata(kk).startv = dec2hex(framedata(kk).startv);
    framedata(kk).endv = dec2hex(framedata(kk).endv);
end