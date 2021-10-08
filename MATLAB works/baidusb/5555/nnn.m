% matlab 文本文件导入，字符串处理
a=tic;
url='http://biz.finance.sina.com.cn/stock/flash_hq/kline_data.php';
rand_num=num2str(randi(10000));
symbol='sz000415';
begin_date='20130701';
end_date='20130730';
type='plain';
filename=[symbol,'.txt'];

%%
str=urlread(url,'get',{'rand',rand_num,...
    'symbol',symbol,...
    'end_date',end_date,...
    'begin_date',begin_date,...
    'type',type});

dlmwrite(filename, str,'')
%%
tic
%[d,o,h,c,l,v] = strread(str,'%s%f%f%f%f%f','delimiter', ',');
%candle(h,l,c,o,'r')
C= textscan(str,'%s%f%f%f%f%f','delimiter', ',');
%p=[C{2},C{3},C{4},C{5},C{6}];
p=[C{2:6}];
d=datenum(C{1});
toc
toc(a)
%%
tic
pd=eval(['{',str,'}']);
p=cell2mat(pd(:,2:end));
td=regexp(str,'....-..-..','match')';
d=datenum(td);
toc
%%
tic
newData = importdata(filename,',',0);
p=newData.data;
d=datenum(newData.textdata);
toc
%%


candle(p(:,2),p(:,4),p(:,3),p(:,1),'r')
%candle(HighPrices, LowPrices, ClosePrices, OpenPrices)
% close all
% candle(p(:,3),p(:,4),p(:,2),p(:,1),'r',d)