%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序10-4 BytesAvailableFcnTest.m
function [] = BytesAvailableFcnTest(mode)
%function [] = BytesAvailableFcnTest(mode)
echotcpip('off');
echotcpip('on',5001);             % 启动tcpip协议echo server
net = tcpip('127.0.0.1',5001);   % 创建tcpip对象
set(net,'BytesAvailableFcn',@mycallback);
set(net,'BytesAvailableFcnCount',3);
set(net,'BytesAvailableFcnMode',mode);
set(net,'UserData',0);
fopen(net);                           % 创建TCP/IP链接
data = sprintf('%3.2f,\n',[0.11 0.22 0.33]);
for kk = 1:length(data(:))
    fwrite(net,data(kk),'char');   % 写入数据
    pause(0.1);
end
fclose(net);
delete(net);
end

function mycallback(obj,event)
bytes = get(obj,'UserData');
BytesAvailable = get(obj,'BytesAvailable');
bytes = bytes + BytesAvailable;
str = fread(obj,BytesAvailable,'char');
fprintf(1,'本次收到数据为"%s", 共读取字节数:%d，本次读取字节数:%d\n',str,bytes,BytesAvailable);
set(obj,'UserData',bytes);
end
