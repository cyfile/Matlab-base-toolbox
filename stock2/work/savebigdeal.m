function matf=savebigdeal
%智能下载大单
%返回大单文件名
%%%%%%%%%%%%%%%%%
%%确定目标文件名
t=clock;
if t(4)<9
    filename=datestr(addtodate(now, -1, 'day'),'yymmdd');
    matf=['bigdeal\',filename,'.mat'];
else
    filename=datestr(date,'yymmdd');
    matf=['bigdeal\',filename,'.mat'];
end
%%

%%确定是否创建，更新文件或是什么也不做
if exist(matf,'file')
    a=load(matf,'t');
    if a.t(4)>15
        return%什么也不做
    end
    %更新文件
else
    prompt = {'创建新文件的文件名:'};
    dlg_title = '需要创建新文件吗？';
    num_lines = 1;
    def = {matf};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    %msgbox(['文件',fil,'创建成功！'],'创建mat文件','help')
    if  isempty(answer)%判断是否创建新文件
        return%不创建
    else
        matf=answer{1};%创建
    end
end

%%
%%读取数据，创建文件
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
[~,~,~,totp]=regexp(str,'(?<=共)\d*(?=页)');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%

S=regexp(str(st:en(end)),'(?<=>)[^\n%看吧<]*(?=%?<)','match');
s=reshape(S,9,[])';
for k=2:str2double(totp{1})
    s2=onepage(k);
    s=[s;s2];
    %     l=size(s,1);
    %     matObj.s(end+1:end+l,:) = s;%这里一个是数字一，一个是字母l
end

save(matf,'s','t','-v7.3')


% filename=datestr(date,'yymmdd');
% matf=['bigdeal\',filename,'.mat'];
%
% matObj = matfile(matf,'Writable',true);

%%



