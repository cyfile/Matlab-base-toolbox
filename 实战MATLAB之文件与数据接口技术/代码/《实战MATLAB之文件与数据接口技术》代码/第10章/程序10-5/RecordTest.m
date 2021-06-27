%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 10-5 RecordTest.m
function [] = RecordTest(mode)
% function [] = RecordTest(mode)
% mode可以设置为'compact'和'verbose'两种模式
echoudp('off');
echoudp('on',5001);           % 启动udp协议echo server
net = udp('127.0.0.1',5001); % 创建对象
set(net,'RecordDetail',mode);
fopen(net);                     % 创建链接
record(net,'on');
data = [0.11 0.22 0.33];
fwrite(net,data(:),'float'); % 写入数据
fread(net,3,'float');
record(net,'off');
fclose(net);
delete(net);
echoudp('off');
end