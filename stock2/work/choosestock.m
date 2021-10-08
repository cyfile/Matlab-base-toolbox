function resu=choosestock(n)
%挑选目标股票
%参数n用来指定最多选取的股票数，现由第5行固定为3
%
n=3;
%%
fil=savebigdeal;

profileofbigdeal(fil);
[scod,tmp]=goodstockofbigdeal(fil);

%%
hold on
plot(tmp(:,1))%总单
plot(0.5*tmp(:,1))%1/2总单
plot(tmp(:,2),'r')%买单
plot(tmp(:,3),'g')%卖单
plot(tmp(:,4),'c')%其他单
set(gca,'XTickLabel',scod)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=cell2mat(scod);
ind1=find(a(:,1)>'1');

a=tmp(:,2)-0.5*tmp(:,1);
[b,ix]=sort(a(ind1),'descend');

m=min(sum(b>1),n);
resu=cell(m,1);
for k=1:m
        resu{k,1}=scod{ind1(ix(k))};
end

