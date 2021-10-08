% 向量化函数，函数句柄以及fminbnd函数
clear
close all

 

f=@(y) @(x) -(y.*x.^2+y.*x+y.^3+3);
f1_20=arrayfun(f,1:20,'UniformOutput', false);


figure 
hold on

 

g=@(fh,ind) plot3(1:20,ind.*ones(1,20),-fh(1:20));
cellfun(g,f1_20,num2cell(1:20));

 

fmaxx=cellfun(@(fh) fminbnd(fh,1,20),f1_20);
fmaxy=cellfun(@(fh,maxx) -fh(maxx),f1_20,num2cell(fmaxx));
plot3(fmaxx,1:20,fmaxy,'r.','markersize',20)


view(-30,45)