% for k =1:10
% [A,Ind]= imread([matlabroot,'\bin\win64\matlab.ico'],'ico',k);
% size(A,1)
% end
%%
A = imread([matlabroot,'\bin\win64\matlab.ico'],'ico',8);
imshow(A)
imwrite(A,'bbb.ico','ico')
% imformats 里面ico没有write方法
gzip('bbb.ico')
%%
gzip('aaa.ico')


%%
% webread 得到的只有数据内容没有请求头
data = webread('http://www.baidu.com');
data = webread('http://www.baidu.com/favicon.ico');
%%
%%
% matlab prompt 是单线程的,再开一个matlab 运行服务器程序
% !matlab -nojvm -nosplash -r "localechoserver" &
% !matlab -nodisplay -nosplash -r "localechoserver" &
!matlab -nodesktop -nosplash -r "localechoserver" &
%%
% 反查 ip 的网站 ipadress
% https://www.ipaddress.com/
ip = '42.239.61.133';