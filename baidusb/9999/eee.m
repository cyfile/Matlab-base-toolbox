% hammer.m

clear
a=3*rand(1,10000);
A=floor(a);

B=A;
B(1)=[];
C=B;
C(1)=[];

A(end)=[];
A(end)=[];
B(end)=[];

sam=cellstr(num2str([A',B',C']));
sam=strrep(sam,' ','');
sam=str2num(cell2mat(sam));
suni=unique(sam);
n =hist(sam,suni);
plot(1:length(suni),n/mean(n),'*r')
set(gca,'XTickLabel',{suni'},...
    'XTick',1:length(suni))
m=reshape(n,3,9)
bar(m,'stack')