% neuralperceptron3

echo off
clc
clear
figure
cla
s=2*rand(2,20)-1;

%%
p=tan(rand(2)*s*1.1)/tan(1.1);%1.1是试出来的一个好值，
plot(p)
%%
t=ceil(s);
% t=sum(t);

plotpv(p,t)

net=newp([-1 1;-1 1],2);

%clh=plotpc(net.IW{1},net.b{1});


net=init(net);
net.adaptParam.passes=1;
clh=plotpc(net.IW{1},net.b{1});


e=1;
h=msgbox('abort','abend','warn');

while(sse(e)&ishandle(h))
    [net,y,e]=adapt(net,p,t);
    clh=plotpc(net.IW{1},net.b{1},clh);
    %axis auto
    pause(0.7)   
end

p1=[.7;-.2];
t1=sim(net,p1);
hold on


ya=get(gca,'ylim');
xa=get(gca,'xlim');
plotpv(p1,t1);
set(gca,'ylim',ya,'xlim',xa)

vh=findobj(gca,'type','line');
set(vh(1),'color','red');
disp('over!')