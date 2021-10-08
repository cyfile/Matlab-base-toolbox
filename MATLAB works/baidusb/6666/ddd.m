% 单因素方差分析
% 
% 指标 因素 水平
% 
% 总偏差平方和(总变差)=组内平方和(误差平方和)+组间平方和(效应平方和)

a=randi([2,10],1,randi([2,6]));
b=arrayfun(@(x) randi(20,x,1),a,'Un', false);

alll=vertcat(b{:});
r=var(alll,1);
R=r*sum(a)

se=cellfun(@(x) var(x,1),b);
sa=(cellfun(@(x) mean(x),b)-mean(alll)).^2;
R0=(se+sa)*a'

 

k=cellfun(@(x) x(:),b,'un',false);
vertcat(k{:});