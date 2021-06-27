%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 9-3 Serial_testBreakInterrupFcn.m
function Serial_testBreakInterruptFcn()
%% Serial_testBreakInterruptFcn.m
s = serial('COM1');
% s.BaudRate = 9600;
% s.DataBits = 8;
s.BreakInterruptFcn =@myCallback;
fopen(s);
disp('Send a string!');
fprintf(s,'hello');
disp('Receive the string!');
data=fgetl(s);
disp(strcat('The string is "',data,'"!'));
disp('Send a break!');
serialbreak(s);
pause(1); % wait a second to get the break
disp('Close the serial port.');
fclose(s);
end
%% myCallback function
function myCallback(obj,event)
   display('OK! Receive a break!');
end
