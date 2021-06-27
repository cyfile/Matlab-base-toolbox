%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 11-3 ReapeatOutputPropertyTest.m
ao = analogoutput('winsound'); % 创建模拟输出设备对象
addchannel(ao,1);            % 添加通道
ao.SampleRate = 8000;        % 设置采样率
t = linspace(0,1,8000);
y = chirp(t,500,1,2000);     % 生成chirp信号
spectrogram(y,256,250,256,8000,'yaxis');%查看chirp信号的时频特性
putdata(ao,y');              % 将信号载入缓存
set(ao,'RepeatOutput',3);    % 设置额外输出的次数
start(ao);                   % 启动模拟输出对象
pause(15);                   % 暂停15秒以使信号有足够的输出时间
stop (ao);
delete(ao);
clear ao;
