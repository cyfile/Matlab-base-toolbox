%% Matlab自带 tcpclient 函数,
%% Instrument Control Toolbox 也有这个函数的重载
t = tcpclient('www.baidu.com', 80);

write(t, uint8(['GET /favicon.ico HTTP/1.1',char([13 10]),'Accept-Encoding: gzip',char([13 10]),char([13 10])]) )
pause(0.1)
len = t.BytesAvailable;
data = read(t);
char(data) %%     Content-Encoding: gzip      Content-Length: 1966
%%
clear t
%%
data(len-1966-10:len-1966)
char(data(len-1966-10:len-1966))
%%
zipimage = data(len-1966+1:end);
fileID = fopen('aaa.ico.GZip','w');
fwrite(fileID , zipimage)
fclose(fileID);

gunzip('aaa.ico.GZip')
%
img = imread('aaa.ico');
imshow(img)


%% =================================================================

%%
f1 = matlab.net.http.HeaderField('Accept-Encoding', 'gzip');
request = matlab.net.http.RequestMessage([],f1,[]);

uri = matlab.net.URI('https://www.baidu.com/favicon.ico');
options = matlab.net.http.HTTPOptions('ConnectTimeout',20,'ConvertResponse',0, ...
'CertificateFilename',[])

complete(request,uri)
[response, request] = request.send(uri, options)

fileID = fopen('aaa.ico','w');
fwrite(fileID , response.Body.Data)
fclose(fileID);

%%
img2 = imread('https://www.baidu.com/favicon.ico');
imshow(img2)
img3 = webread('https://www.baidu.com/favicon.ico');
imshow(img3)
%%
