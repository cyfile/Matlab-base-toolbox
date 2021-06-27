echotcpip('on',5001);               % 启动tcpip协议echo server

%%
net = tcpip('122.10.10.10',5001)
net = tcpip('baidu.com',80)
net = tcpip('220.181.38.148',80)
net = tcpip('192.168.0.1',5001)
net = tcpip('192.168.0.10',5001)
net = tcpip('192.168.0.111',5001)
net = tcpip('127.0.0.111',5001)
net = tcpip('127.0.0.1',5001)

set(net,'BytesAvailableFcn',@bbbb);
set(net,'RecordDetail','verbose');  % 可以设置为'compact'和'verbose'两种
record(net,'on');
%%
fopen(net)   % 创建TCP/IP链接
message = uint8(['GET / HTTP/1.1',char([13 10]),'Host: baidu.com',char([13 10]),char([13 10])]); 
%%
for k=1:2
fwrite(net,message)    % 写入数据

 s0 = struct( 'RecordStatus', net.RecordStatus, ...
     'TransferStatus', net.TransferStatus, 'BytesAvailable', net.BytesAvailable, ...
     'ValuesReceived', net.ValuesReceived, 'ValuesSent', net.ValuesSent)
 
 pause(0.2);
 
 s2 = struct( 'RecordStatus', net.RecordStatus, ...
     'TransferStatus', net.TransferStatus, 'BytesAvailable', net.BytesAvailable, ...
     'ValuesReceived', net.ValuesReceived, 'ValuesSent', net.ValuesSent)
% data = fread(net,nBytes/2);
% char(data(1:10)')
% string(dec2hex(data(1:10)))'
end
%%
record(net,'off');
fclose(net);      % 关闭链接
delete(net);      % 删除tcpip对象，释放设备资源
%%
echotcpip('off')
return
%%%
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
%%
