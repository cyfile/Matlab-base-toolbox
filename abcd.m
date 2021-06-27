

%%

message = char(mod(1:1000, 255)+1);
server(message)

data = client('localhost', 3000)
%%
ip = '61.135.169.125'; 
%ip = '23.77.51.74';
t = tcpclient(ip, 443)
t = tcpclient('localhost', 7)

write(t, uint8(1:10))
write(t, uint8(['GET / HTTP/1.1',char([13 10]),'Host: www.mathworks.com',char([13 10]),char([13 10])]) )
t.BytesAvailable
read(t)
%%
data = webread('http://www.baidu.com')
data = webread('https://www.baidu.com/favicon.ico')
%%
f1 = matlab.net.http.HeaderField('Accept-Encoding', 'gzip');
request = matlab.net.http.RequestMessage([],f1,[]);
uri = matlab.net.URI('https://www.baidu.com/favicon.ico');
options = matlab.net.http.HTTPOptions('ConnectTimeout',20,'ConvertResponse',0, ...
'CertificateFilename',[])
complete(request,uri)
[response, request] = request.send(uri, options)

%%
fieldnames


properties	Class property names
methods	Class method names
methodsview
events	Event names
enumeration