function s=onepage(P)
%读入大单的一页
%P是一个数字
%返回的s是一个含有大单数据的9列的胞数组，每一行是一个大单
%该函数会被savetodaybigdeal调用
url='http://app.finance.ifeng.com/hq/all_stock_bill.php';
page=num2str(P);
by='hq_time';
order='asc';%'desc'
amount='1000';

str=urlread(url,'get',...
    {'page',page,'by',by,'order',order,'amount',amount});

%%
st=strfind(str,'详细');
en=strfind(str, '查看');

%%%%%%%%%%%%%
%%以下是测试代码，可以在editor里正确显示读取的网页片段
if false
    filename=['bigdeal\',datestr(date,'yymmdd')];
    lookstr(filename,str(st:en(end)));
end
%%测试代码结束
%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%
S=regexp(str(st:en(end)),'(?<=>)[^\n%看吧<]*(?=%?<)','match');
s=reshape(S,9,[])';



