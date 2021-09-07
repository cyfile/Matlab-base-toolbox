%
net = tcpip('127.0.0.1',5003,'NetworkRole','server');
% 127 打头的那个网段都是本机,所以地址的低位不重要.
% 但是端口一定要一致
% !%homepath%\desktop\chrome.lnk 127.0.0.125:5003
%%
if false
    methods(net)
    fieldnames(net)
    % net.InputBufferSize = 512;
    % set(net,'BytesAvailableFcn',@newbytesdisp);
    netstate = struct('TransferStatus', net.TransferStatus,...
        'BytesAvailable', net.BytesAvailable,'ValuesReceived', net.ValuesReceived, ...
        'ValuesSent', net.ValuesSent)
end
%%
fclose(net);
fopen(net);
%%
req = 0;
for k= 1:9
    fprintf(1,'waiting(%d) for data...\n',k)
    num = 1;
    while net.BytesAvailable
        fprintf(1,'[%d] ',net.BytesAvailable)
        data = fread(net,net.BytesAvailable,'uchar');
        % flushinput(net)
        if num == 1
            n =find(data==13,1,'first');
            fprintf( 1 ,'first line: [%s]\n',data(1:n-1)')
            num = 2;
        end
        if isequal(data(end-3:end),[13;10;13;10])
            req=req+1;
            fprintf( 1 ,'request %d finished. ',req)
            
            if req==1
                %        baiduhtml(net)
                simplehtml(net)
                fprintf( 1 ,'send html response.\n')
            else
                favoriteicon(net)
                fprintf( 1 ,'send icon response.\n')
            end
            
        end
        pause(0.02)
    end
    pause(0.02)
end
%%
fclose(net);      % 关闭链接

delete(net);      % 删除tcpip对象，释放设备资源
% clear('net');     % 清除MATLAB工作区的变量
%%
function simplehtml(net)
message = '<!DOCTYPE html><!--STATUS OK--><html><head></head><body>sometext</body></html>';
head =[ 'HTTP/1.1 200 OK',char([13 10]),...
    'Content-Length: ',num2str(size(message,2)),char([13 10 13 10])];
fwrite(net,[head message])    % 写入数据
end
%%
function baiduhtml(net)
webhtml = webread('http://www.baidu.com');
len = numel(webhtml);
head =[ 'HTTP/1.1 200 OK',char([13 10]),...
    'Content-Length: ',num2str( len ),char([13 10 13 10])];
fwrite(net,head)
%%
for k=1:512:len-512
    fwrite(net,webhtml(k:k+511))
    % flushoutput(net)
    pause(0.002)
end
fwrite(net,webhtml(k+512:len))
end
%%
function favoriteicon(net)
fileID = fopen('../aaa.ico.gz','r');
A =  fread(fileID, 'uint8=>uchar' );
fclose(fileID);
len = numel(A);
head =[ 'HTTP/1.1 200 OK',char([13 10]),...
    'Content-Encoding: gzip',char([13 10]),...
    'Content-Type: image/x-icon',char([13 10]),...
    'Content-Length: ',num2str( len ),char([13 10 13 10])];
fwrite(net,head)
%%
for k=1:512:len-512
    fwrite(net,A(k:k+511))
    % flushoutput(net)
    pause(0.002)
end
fwrite(net,A(k+512:len))
end
%%

