function daydata(symbol,dat)
%
%

%%
% symbol='sh600000';
% begin_date='20130701';
% end_date='20130730';

begin_date=datestr(addtodate(dat,-100,'day'),'yyyymmdd');
end_date=datestr(addtodate(dat,-1,'day'),'yyyymmdd');

%%

url='http://biz.finance.sina.com.cn/stock/flash_hq/kline_data.php';
rand_num=num2str(randi(10000));
type='plain';

%%
str=urlread(url,'get',{'rand',rand_num,...
    'symbol',symbol,...
    'end_date',end_date,...
    'begin_date',begin_date,...
    'type',type});
%%
% filename=[symbol,'.txt'];
% dlmwrite(filename, str,'')
%%

%[d,o,h,c,l,v] = strread(str,'%s%f%f%f%f%f','delimiter', ',');
%candle(h,l,c,o,'r')
C= textscan(str,'%s%f%f%f%f%f','delimiter', ',');
[d,o,h,c,l,v] =C{:};
%p=[C{2},C{3},C{4},C{5},C{6}];
p=[C{2:6}];
%d=datenum(C{1});


candle(p(:,2),p(:,4),p(:,3),p(:,1),'r')
%candle(HighPrices, LowPrices, ClosePrices, OpenPrices)
% close all
% candle(p(:,3),p(:,4),p(:,2),p(:,1),'r',d)

