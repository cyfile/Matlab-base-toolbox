% linearlayer719

clc
clear

clf
n=300;
ti=linspace(0,5,n);

x=sin(sin(ti).*ti*10);
clc

% t=[sin(ti(1:n/2)*3.86524*pi) sin(ti(n/2+1:end)*2*pi)];
% p=t;
k=3;
tp=repmat([x,0],1,k);
tp(end+1-k:end)=[];
p=triu(reshape(tp,n,[])');

t=filter([1 .5 -1.5],1,x);

plot(ti,t,'k',ti,x,'-')
hold on

%%

net=newlind(p,t);

r=sim(net,p);
plot(ti,t-r,'g',ti,r,'r+','MarkerSize',2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % net=newlin([-1 1],1,[1 2 3 4 5],.1);
% % [net,y,e]=adapt(net,con2seq(p),con2seq(t));

% % plot(ti,cell2mat(y),'-.')
% % plot(ti,cell2mat(e),'r')