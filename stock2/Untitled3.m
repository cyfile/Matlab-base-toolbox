url='http://biz.finance.sina.com.cn/stock/flash_hq/kline_data.php';
rand_num=num2str(randi(10000));
symbol='sz000415';
begin_date='20130701';
end_date='20130730';
type='plain';
filename=[symbol,'.txt'];
% %%%%%%%%%%
% str=urlread(url,'get',{'rand',rand_num,...
%     'symbol',symbol,...
%     'end_date',end_date,...
%     'begin_date',begin_date});
%%%%%%%%%%%%%
%%
str=urlread(url,'get',{'rand',rand_num,...
    'symbol',symbol,...
    'end_date',end_date,...
    'begin_date',begin_date,...
    'type',type});
dlmwrite(filename, str,'')

[d,o,h,c,l,v] = strread(str,'%s%f%f%f%f%f','delimiter', ',');
d=datenum(d);
candle(h,l,c,o,'r')
data=eval(['{',str,'}']);
%%
newData = importdata(filename,',',0);
p=newData.data(:,1:4);
d=datenum(newData.textdata);
candle(p(:,2),p(:,4),p(:,3),p(:,1),'r')
%%


%candle(HighPrices, LowPrices, ClosePrices, OpenPrices)

% close all
% candle(p(:,3),p(:,4),p(:,2),p(:,1),'r',d)
