%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-1 testtcpip.m
function [] = testtcpip()
%创建tcpip对象
echotcpip('off');
echotcpip('on',5001);               % 启动tcpip协议echo server
net = tcpip('127.0.0.1',5001); % 创建tcpip对象
fopen(net);                           % 创建TCP/IP链接
fwrite(net,[1 2 3 4 5 6],'int16');% 写入数据
pause(0.1);
 
%查看发送的元素个数（16位整型，六个元素）
disp(strcat('发送元素个数为',num2str(net.ValuesSent),'个'));
%查看接收的数据
nBytes = get(net,'BytesAvailable');
if nBytes>2
    data = fread(net,nBytes/2,'int16');
    data = reshape(data,1,length(data(:)));
    disp('接收到的数据为:');
    disp(data); 
else
    disp('没有收到数据');
end
 
fclose(net);      % 关闭链接
delete(net);      % 删除tcpip对象，释放设备资源
clear('net');     % 清除MATLAB工作区的变量
end