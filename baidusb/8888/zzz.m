% neuralperceptron2

echo off
clc
clear
figure
cla
p=2*rand(2,20)-1;
t=ceil(rand(2,2)*p/2);
% t=sum(t);

plotpv(p,t)

net=newp([-1 1;-1 1],2);

%clh=plotpc(net.IW{1},net.b{1});


net=init(net);
net.adaptParam.passes=1;
clh=plotpc(net.IW{1},net.b{1});


e=1;

while(sse(e))
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