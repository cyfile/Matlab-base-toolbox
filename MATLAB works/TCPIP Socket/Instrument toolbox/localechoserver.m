%
net = tcpip('localhost' ,5678,'NetworkRole','server');
%%
fclose(net);
fopen(net);
%%
req = 0;
for k= 1:20
    fprintf(1,'waiting(%d) for data ...\n',k)
    
    while net.BytesAvailable
        req=req+1;
        fprintf(1,' --- request %d --- \n ',net.BytesAvailable)
        fprintf(1,'recieved data[%d]: ',net.BytesAvailable)
        data = fread(net,net.BytesAvailable,'uchar');
        % flushinput(net)
        fprintf( 1 ,' [%s]\n',data');
        %
        
        message = 'aaaaaaaGET /aaaaaa HTTP/1.1 Host: baidu.combbbbbbbbb';
        fwrite(net,message)
        fprintf( 1 ,' echo some message ...\n');
        
        pause(0.02)
    end
    pause(2)
end
%%
fclose(net);      % 关闭链接

delete(net);      % 删除tcpip对象，释放设备资源
% clear('net');     % 清除MATLAB工作区的变量


