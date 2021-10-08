% https://www.mathworks.com/help/instrument/tcpip.html
% tcpip and its object properties will be removed.
% Use tcpclient or tcpserver and its properties instead

echotcpip('on',5001);               % 启动tcpip协议echo server

%%
net = tcpip('122.10.10.10',5001)
%
net = tcpip('baidu.com',80)
net = tcpip('220.181.38.148',80)
%
net = tcpip('192.168.0.1',5001)
net = tcpip('192.168.0.10',5001)
net = tcpip('192.168.0.111',5001)
%
net = tcpip('127.0.0.111',5001)
net = tcpip('127.0.0.1',5001)

set(net,'BytesAvailableFcn',@newbytesdisp);
set(net,'RecordDetail','verbose');  % 可以设置为'compact'和'verbose'两种
net.RecordName = 'MyRecord.txt';

%%
fopen(net)   % 创建TCP/IP链接
record(net,'on');

message = uint8(['GET / HTTP/1.1',char([13 10]),'Host: baidu.com',char([13 10]),char([13 10])]);
%%
for k=1:3
    fwrite(net,message)    % 写入数据
    %%
    netstate = struct( 'RecordStatus', net.RecordStatus, ...
        'TransferStatus', net.TransferStatus, 'BytesAvailable', net.BytesAvailable, ...
        'ValuesReceived', net.ValuesReceived, 'ValuesSent', net.ValuesSent)
    
    pause(0.2);
    
    netstate = struct( 'RecordStatus', net.RecordStatus, ...
        'TransferStatus', net.TransferStatus, 'BytesAvailable', net.BytesAvailable, ...
        'ValuesReceived', net.ValuesReceived, 'ValuesSent', net.ValuesSent)
    %%
    %     newbytesdisp(net,[])
end
%%
record(net,'off');
fclose(net);      % 关闭链接
delete(net);      % 删除tcpip对象，释放设备资源
%%
clear('net');     % 清除MATLAB工作区的变量
%%
echotcpip('off')
%%
return


methods(net)
fieldnames(net)
% net.InputBufferSize = 512;
% set(net,'BytesAvailableFcn',@newbytesdisp);
netstate = struct('TransferStatus', net.TransferStatus,...
    'BytesAvailable', net.BytesAvailable,'ValuesReceived', net.ValuesReceived, ...
    'ValuesSent', net.ValuesSent)
