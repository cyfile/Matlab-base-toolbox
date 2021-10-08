%quotes
url2='http://download.finance.yahoo.com/d/quotes.csv';
%url2='http://finance.yahoo.com/d/quotes.csv';

%historical quotes 
%http://ichart.finance.yahoo.com/table.csv?s=000300.SS
%&a=06&b=3&c=2013&d=07&e=10&f=2013&g=d&ignore=.csv
url='http://ichart.finance.yahoo.com/table.csv';
url='http://table.finance.yahoo.com/table.csv';
s='601857.SS';
a='06';
b='3';
c='2013';
d='07';
e='10';
f='2013';
g='d';
ignore='.csv';
%%
urlname=[url,'?','s=',s,...
    '&a=',a,'&b=',b,'&c=',c,...
    '&d=',d,'&e=',e,'&f=',f,...
    '&g=',g,...
    '&ignore=',ignore];
str = urlread(urlname);
%%
str = urlread(url,'get',{'s',s,...
    'a',a,'b',b,'c',c,...
    'd',d,'e',e,'f',f,...
    'g=',g,...
    'ignore=',ignore});
%%
filename=[s,'.txt'];
dlmwrite(filename, str,'')
%M = dlmread(filename,',', 1, 1);
%%
C= textscan(str,'%s%f%f%f%f%f%f','delimiter', ',','HeaderLines',1,'CollectOutput',1);
p=C{2};
d=datenum(C{1});%yahoo 越新的数据越靠前
p=flipud(p);
d=flipud(d);
%%
%candle(HighPrices, LowPrices, ClosePrices, OpenPrices)
candle(p(:,2),p(:,3),p(:,4),p(:,1),'g')
% close all
% candle(p(:,2),p(:,3),p(:,4),p(:,1),'r',d)
%%
matf=[s,'.mat'];
save(matf,'p','d','-v7.3')
matObj = matfile(matf,'Writable',true);
matObj.p(end+1,:) = matObj.p(end,:);
%%
st=datestr(matObj.d(end,1),'mm-dd-yyyy')
st=textscan(st,'%s %s %s','Delimiter','-')
[a,b,c]=st{:}

st=datestr(date,'mm-dd-yyyy')
st=textscan(st,'%s %s %s','Delimiter','-')
[d,e,f]=st{:}
