%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 11-2 PrintInitialTriggerTimeScript.m
ai = analoginput('winsound');
addchannel(ai,1);
start(ai);
abstime = ai.InitialTriggerTime;
t = fix(abstime);                   % 取整
sprintf('%d-%d-%d %d:%d:%d',t(1),t(2),t(3),t(4),t(5),t(6))
stop (ai);
delete(ai);
clear ai;
