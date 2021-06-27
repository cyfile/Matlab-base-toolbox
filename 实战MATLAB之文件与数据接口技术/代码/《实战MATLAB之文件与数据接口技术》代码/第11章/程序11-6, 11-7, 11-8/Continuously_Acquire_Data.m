%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%程序 11-6 Continuously_Acquire_Data.m
ai = analoginput('winsound');
addchannel(ai,1);
set(ai,'SamplesPerTrigger',Inf);%设置采样点数为无限
set(ai,'TimerPeriod',0.5);      %设置计时器回调函数执行周期
figure;                     % 绘制实时信号的频谱图
P = plot(zeros(1000,1));
T = title(['实时信号FFT,回调函数执行次数:', num2str(0)]);
xlabel('频率(Hz)')
ylabel('幅度')
grid on;
set(ai,'TimerFcn',{@demoai_continuous_timer_callback,P,T});
start(ai);
while(strcmpi(get(ai,'Running'),'On'))%连续执行直至接收到Stop状态
   pause(0.5);
end
allData = get(ai,'UserData');

% 绘制采集到的所有数据
figure;
plot(allData.time,allData.data);
xlabel('时间(s)')
ylabel('信号幅度(Volts)')
title('采集数据');
grid on;

delete(ai);
clear all; % 清除变量和设备对象
