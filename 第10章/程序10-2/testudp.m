%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-2 testudp.m
function [] = testudp()
echoudp('off');
echoudp('on',4012);    % 启动udp应答服务器
%创建udp对象
u = udp('127.0.0.1','RemotePort',4012,'LocalPort',4013);
fopen(u);
%发送数据
fwrite(u,1:5,'int16');
pause(0.01);
%接收数据
A = fread(u,10,'int16');
A = reshape(A,1,length(A(:)));
disp('接收到的数据为:');
disp(A);
echoudp('off');
fclose(u);      % 关闭网络接口
delete(u);      % 删除udp对象，释放网络设备
end