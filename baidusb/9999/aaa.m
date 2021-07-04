% neuralperceptron

echo off
clc
figure
cla
p=[-1 -.5 +.3 -.1;
   -.5 +.5 -.5 +1.0];
t=[1 1 0 0];


net=newp([-1 1;-1 1],1);
watchon;
plotpv(p,t)
clh=plotpc(net.IW{1},net.b{1});

net=init(net);
net.adaptParam.passes=1;
clh=plotpc(net.IW{1},net.b{1},clh);
axis auto
e=[1];
while(sse(e))
    [net,y,e]=adapt(net,p,t);
    e
    clh=plotpc(net.IW{1},net.b{1},clh);
    axis auto
    pause   
end

p1=[.7;1.2];
a=sim(net,p1);
hold on
plotpv(p1,a);
axis auto
vh=findobj(gca,'type','line');
set(vh(1),'color','red');