% linearlayer718

clc
clear

clf
n=500;
ti=linspace(0,5,n);
%%
clf

t=[sin(ti(1:n/2)*6.8475*pi) sin(ti(n/2+1:end)*1.81818*pi)];
p=t;
% k=5;
% tp=repmat([t,0],1,k);
% tp(end+1-k:end)=[];
% p=tril(reshape(tp,n,[])');

plot(ti,t,'k')
hold on
% net=newlind(p,t);
net=newlin([-1 1],1,[1 2 3 4 5],.1);

[net,y,e]=adapt(net,con2seq(p),con2seq(t));

% r=sim(net,p);

plot(ti,cell2mat(y),'-.')

plot(ti,cell2mat(e),'r')