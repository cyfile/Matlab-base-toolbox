%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%程序 11-9 wavPutout.m
function [] = wavPutout()
[y, Fs] = wavread([matlabroot ...
    '\toolbox\sl3d\vrealm\program\worlds\audio\tms.wav']);
ao = analogoutput('winsound', 0);
addchannel(ao, [1 2]);
set(ao, 'SampleRate', Fs);
data = [y y];
putdata(ao, data);
figure;
P = plot(zeros(500,1));
set(ao,'TimerPeriod',500/Fs);%每500点绘制一次波形
set(ao,'TimerFcn',{@wavPutout_callbackFcn,P,y});
start(ao);
end
