%使用同一函数提取单股大单数据的几种不同方法
tic
url='http://app.finance.ifeng.com/hq/stock_bill.php?code=sh600663';
str=urlread(url);
toc
disp('--------------------------')
disp('--------------------------')
%%
sp=[sprintf('\r\n'),char(32*ones(1,13))];
[~,fi]=regexp(str, ['>涨跌幅</th>',sp,'</tr>',sp,char(60)]);
%double(sprintf('\r\n '))
%k = strfind(tr, ['>涨跌幅</th>',sprintf('\r\n'),char(32*ones(1,13)),char(60)]);
la = strfind(str, '<div class="tt02">说明');
%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%
%%
tic
dt='<td>%8s</td> ';%成交时间
dp='<td>%f</td> ';%成交价格
dq='<td>%f</td> ';%成交额(万)
da='<td>%f</td> ';%成交量(手)
sb='<td><span class= %*s >%4s</span></td> ';%大单性质
ud='<td><span class= %*s >%f</span></td> ';%涨跌额 
udm='<td><span class= %*s >%f%% </span></td> ';%涨跌幅 两个百分号后面必须有空格
fmat=['<tr> ',dt,dp,dq,da,sb,ud,udm, '</tr>'];    

C= textscan(str(fi:la),fmat,...
    'whitespace',' \n\r"',...
    'CollectOutput',1);
toc
%%%
tic
C2= textscan(str(fi:la-1),'%8s%f%f%f%4s%f%f%%',...
    'CommentStyle',{'<', '>'},...
    'whitespace',' \n\r\t',...
    'CollectOutput',1);
toc
%%%
tic
wsp=['a':'z','<A="/%> \n\r\t'];
C3= textscan(str(fi:la),'%8s%f%f%f%4s%f%f%%',...
    'whitespace',wsp,...
    'MultipleDelimsAsOne',true,...
    'CollectOutput',1);
toc
%%
%%%%%%%%%%%%%
disp('++++++++++++++++++++++')
%%%%%%%%%%%%%
tic
tim=datenum(C{1},'HH:MM:SS');

sb=ones(length(C{3}),1);
sb(cellfun(@(x) isequal(x,'卖盘'),C{3}))=-1;
sb(cellfun(@(x) isequal(x,'其他'),C{3}))=0;

pd=[C{2:2:4}];

toc

%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%
disp('--------------------------')
%%%%%%%%%%%%%%
%%
tic
S=regexp(str(fi:la),'[0-9.-]*','match');
S2=regexp(str(fi:la),'买盘|卖盘|其他','match');
s=reshape(S,8,[])';


%%


tim2=datenum(cell2mat(s(:,1:3)),'HHMMSS');
%p=cellfun(@eval,s(:,4:8)))
%p=cellfun(@str2num,s(:,4:8));

sb2=ones(length(S2),1);
sb2(cellfun(@(x) isequal(x,'卖盘'),S2))=-1;
sb2(cellfun(@(x) isequal(x,'其他'),S2))=0;

pd2=cellfun(@str2double,s(:,4:8));

toc



