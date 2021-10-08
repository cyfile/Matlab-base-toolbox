tic
url='http://app.finance.ifeng.com/hq/all_stock_bill.php';
page='1';
by='hq_time';
order='asc';%'desc'
amount='1000';

str=urlread(url,'get',...
{'page',page,'by',by,'order',order,'amount',amount});

[~,~,~,totp]=regexp(str,'(?<=共)\d(?=页)');
toc



%%
st=strfind(str,'详细');
en=strfind(str, '查看');


%%
%dlmwrite(['bigdeal',datestr(date,'yymmdd'),'.txt'], str,'')
filename=['bigdeal',datestr(date,'yymmdd')]
fileID=[filename,'.txt'];
fid = fopen(fileID, 'w');
s = regexprep(str(st:en(end)), '%', '%%');
fprintf(fid, s);
%fwrite(fid, '文字')
fclose(fid);


%%



%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%
S=regexp(str(st:en(end)),'(?<=>)[^\n%看吧<]*(?=%?<)','match');


s=reshape(S,9,[])';

matf=[filename,'.mat'];
save(matf,'s','-v7.3')
matObj = matfile(matf,'Writable',true);
matObj.p(end+1,:) = matObj.p(end,:);

%%


S=regexp(str(st:en(end)),'(?<=>)[0-9.-]*(?=<)','match');
S=regexp(str(st:en(end)),'(?<=>)(\d{2}:\d{2}:\d{2})(?=<)','match');
S=regexp(str(st:en(end)),'(?<=>)[^0-9\n看吧<]*(?=<)','match');
s=reshape(S,8,[])';
'\w*(?=vision).', 'match'
%%
S{5}