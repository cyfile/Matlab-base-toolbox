%%
% matlab prompt 是单线程的,再开一个matlab 运行服务器程序
% !matlab -nojvm -nosplash -r "localechoserver" &
% !matlab -nodisplay -nosplash -r "localechoserver" &
!matlab -nodesktop -nosplash -r "localechoserver" &
%%
% 反查 ip 的网站 ipadress
% https://www.ipaddress.com/
ip = '42.239.61.133';
%
ip = '127.0.0.1';
netClient = tcpip( ip ,5678);
%%
fclose(netClient);
fopen(netClient);   % 创建TCP/IP链接
%%
nBytes = netClient.BytesAvailable
message = 'ClientClientClientClient';
fwrite(netClient,message)
%%
while netClient.BytesAvailable == 0
    pause(0.01)
end
%%
nBytes = netClient.BytesAvailable

%     data = fread(netObj,nBytes/2,'int16');
data = fread(netClient,nBytes,'uchar')';
fprintf(1,'接收到的数据: [%s]\n ',data)
% fprintf(1,'接收到的数据: [%s]\n ',char(txt))


%%
fclose(netClient);      % 关闭链接
delete(netClient);      % 删除tcpip对象，释放设备资源