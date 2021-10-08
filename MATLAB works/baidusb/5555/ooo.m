% Matlab xml文件操作 网络文件读取
a=tic;
url='http://biz.finance.sina.com.cn/stock/flash_hq/kline_data.php';
rand_num=num2str(randi(10000));
symbol='sz000415';
begin_date='20130701';
end_date='20130730';
type='plain';
filename=[symbol,'.xml'];
urlname=[url,'?','rand=',rand_num,...
    '&symbol=',symbol,...
    '&end_date=',end_date,...
    '&begin_date=',begin_date];
%str=urlread('http://biz.finance.sina.com.cn/stock/flash_hq/kline_data.php
%?&rand=random(1000)&symbol=sz000415&end_date=20130730
%&begin_date=20130101&type=plain');

%%
xDoc=xmlread(urlname);
xmlwrite(filename,xDoc)
%%

DOMnode= xmlread(filename);
DOMnode=xDoc;
% xRoot=DOMnode.getDocumentElement()
% xRoot.getNodeName()
% methods(theNode)
% childNodes = theNode.getChildNodes
tic
cont=DOMnode.getElementsByTagName('content');
numcont = cont.getLength;

tdate= cell(numcont,1);
pdata = struct('o',tdate,'c',tdate,'h',tdate,'l',tdate,'v',tdate);

for count = 1:numcont
    oneitem =cont.item(count-1);
    tdate{count}=char(oneitem.getAttribute('d'));
    pdata(count) = struct(              ...
        'o', char(oneitem.getAttribute('o')),...
        'c', char(oneitem.getAttribute('c')),...
        'h', char(oneitem.getAttribute('h')),...
        'l', char(oneitem.getAttribute('l')),...
        'v', char(oneitem.getAttribute('v')));
end

d=cellfun(@datenum,tdate);
pd=struct2cell(pdata)';
p=cellfun(@str2num, pd);
toc
toc(a)
%%
%candle(HighPrices, LowPrices, ClosePrices, OpenPrices)
candle(p(:,3),p(:,4),p(:,2),p(:,1),'r')
% close all
% candle(p(:,3),p(:,4),p(:,2),p(:,1),'r',d)