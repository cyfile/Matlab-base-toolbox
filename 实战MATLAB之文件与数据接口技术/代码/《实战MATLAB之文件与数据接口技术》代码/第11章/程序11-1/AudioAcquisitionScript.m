%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 11-1 AudioAcquisitionScript.m
% 声音信号采集
ai = analoginput('winsound');
addchannel(ai,1);                  % 添加通道
set(ai,'timeout',5);               % 定义超时值为5秒
set(ai,'SamplesPerTrigger',32768); % 设置采样点数为32768
start(ai);                         % 开启设备对象
fs = ai.SampleRate;              % 获取采样频率
[data time] = getdata(ai);      % 获得采样数据
Ns = ai.SamplesPerTrigger;      % 获取采样点数
t = [0:Ns-1]/fs;
stop (ai);                         % 关闭设备对象
delete(ai);                        % 删除设备对象
clear ai;
% 计算采集信号的功率谱
data = data - mean(data(:));
h = spectrum.welch;
Hpsd = psd(h,data,'Fs',fs);
% 绘图
figure;
subplot(211)
plot(t,data);    % 绘制原始信号
xlabel('时间(s)');ylabel('幅度');
subplot(212);
plot(Hpsd);      % 绘制功率谱
xlabel('频率(kHz)');ylabel('功率谱(dB/Hz)');
title('');