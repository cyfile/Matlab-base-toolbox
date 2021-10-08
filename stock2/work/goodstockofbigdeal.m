function [scod,tmp]=goodstockofbigdeal(matf)
%
%
if ~nargin
   suf=datestr(date,'yymmdd');
   filename=['bigdeal\',suf];
   matf=[filename,'.mat'];
end



%%%%%%%%%%%%
%%不载入变量直接从文件读入数据的方法
% matObj = matfile(matf);
% n=matObj.s(:,1);
% bs=matObj.s(:,7);
%%该方法结束
%%%%%%%%%%%


load(matf)
%%
n=s(:,1);%股票代码
bs=s(:,7);%买卖性质

co=[strcmp('买盘',bs),strcmp('卖盘',bs),strcmp('其他',bs)];
tmp=sum(co);
disp('截止目前')
disp(['今日大买单共有',num2str(tmp(1)),'单'])
disp(['今日大卖单共有',num2str(tmp(2)),'单'])
disp(['今日其他大单共有',num2str(tmp(3)),'单'])
%%
%[x,xid,y] = grp2idx(n);
k=tabulate(n);
[b,ix]=sort([k{:,2}],'descend');

ea=10;

scod=k(ix(1:ea),1);

aind=zeros(ea,size(n,1));
for m=1:ea
    aind(m,:)=strcmp(scod{m},n);
end
ta=aind*co;

tmp=[b(1:ea)',ta];

%markbuyday(scod);