%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-3 DatagramReceivedFcnTest.m
function [] = DatagramReceivedFcnTest()
%function [] = DatagramReceivedFcnTest()
%DatagramReceivedFcn
echoudp('off');
echoudp('on',5001);            % 启动tcpip协议echo server
net = udp('127.0.0.1',5001); % 创建tcpip对象
set(net,'DatagramReceivedFcn',@mycallback);
set(net,'UserData',0);
set(net,'DatagramTerminateMode','on');
fopen(net);                      % 创建TCP/IP链接
data = [0.11 0.22 0.33];
for kk = 1:length(data(:))
    fwrite(net,data(kk),'float');% 写入数据
    pause(0.1);
end
fclose(net);
delete(net);
echoudp('off');
end
 
function mycallback(obj,event)
bytes = get(obj,'UserData');
BytesAvailable = get(obj,'BytesAvailable');
bytes = bytes + BytesAvailable;
data = fread(obj,BytesAvailable/4,'float');
fprintf(1,'本次收到数据为"%3.2f", 共读取字节数:%d，本次读取字节数:%d\n',data,bytes,BytesAvailable);
set(obj,'UserData',bytes);
end
