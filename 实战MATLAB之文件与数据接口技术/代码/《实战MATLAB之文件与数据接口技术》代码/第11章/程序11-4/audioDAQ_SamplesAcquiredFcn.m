%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 11-4 audioDAQ_SamplesAcquiredFcn.m
function audioDAQ_SamplesAcquiredFcn()
% 测试 SamplesAcquiredFcn回调函数
global ai;
global data;
global time;
ai = analoginput('winsound');
addchannel(ai,1);     %添加通道
set(ai,'SamplesPerTrigger',8000);
set(ai,'SamplesAcquiredFcnCount',4000);
set(ai,'SamplesAcquiredFcn',@myGetdata);
duration = ai.SamplesPerTrigger / ai.SampleRate; % duration
start(ai);
wait(ai,duration);
stop (ai);
delete(ai);
clear ai;
end  % end of function audioDAQ_SamplesAcquiredFcn()

function [] = myGetdata(obj,event)
global ai;
global data;
global time;
[data time] = getdata(ai,4000); % 获得采样数据
figure;
plot(time,data);
xlabel('时间(s)');
ylabel('幅度');
end % end of function myGetdata()

% end of audioDAQ_SamplesAcquiredFcn.m
