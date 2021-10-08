function savetodaybigdeal
%已废弃，使用函数savebigdeal
msgbox('abandoned','abandoned','warn')
return
%
%
url='http://app.finance.ifeng.com/hq/all_stock_bill.php';
page='1';
by='hq_time';
order='asc';%'desc'
amount='1000';

str=urlread(url,'get',...
{'page',page,'by',by,'order',order,'amount',amount});

%%
st=strfind(str,'详细');
en=strfind(str, '查看');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%

S=regexp(str(st:en(end)),'(?<=>)[^\n%看吧<]*(?=%?<)','match');
s=reshape(S,9,[])';

filename=datestr(date,'yymmdd');
matf=['bigdeal\',filename,'.mat'];
save(matf,'s','-v7.3')
matObj = matfile(matf,'Writable',true);

%%
[~,~,~,totp]=regexp(str,'(?<=共)\d*(?=页)');
for k=2:str2double(totp{1})

s=onepage(k);
l=size(s,1);
matObj.s(end+1:end+l,:) = s;%这里一个是数字一，一个是字母l

end

