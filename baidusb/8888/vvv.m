% neuralperceptron3

echo off
clc
clear
figure
% cla
%%

s=2*rand(2,20)-1;

t=ceil(s);
ta=1/2*rand;
tb=1/2*rand;
tt=[1+tb tb;ta,1-ta];
p=tt*s;

p=tan(p)/tan(1);
plotpv(p,t)
%%

% 
% plot(s(1,:)',s(2,:)','o')
% c=1;
% cm=rand(2);
% p=tan(cm*diag([1,1.3])*inv(cm)*s*c)/tan(c);

% t=sum(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

net=newp([-1 1;-1 1],2);

net=init(net);
net.adaptParam.passes=1;
subplot(211)
plotpv(p,t)
text(-1,1,'learnfcn:learnp')
clh=plotpc(net.IW{1},net.b{1});


net2=newp([-1 1;-1 1],2,'hardlim','learnpn');

net2=init(net2);
net.adaptParam.passes=1;
subplot(212)
plotpv(p,t)
text(-1,1,'learnfcn:learnpn')
clh2=plotpc(net2.IW{1},net2.b{1});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e=1;
e2=1;
h=msgbox('abort','abend','warn');

while(sse(e)&sse(e2)&ishandle(h))
    if sse(e)
        [net,y,e]=adapt(net,p,t);
        subplot(211)
        clh=plotpc(net.IW{1},net.b{1},clh);
    end
    if sse(e2)
        [net2,y2,e2]=adapt(net2,p,t);
        subplot(212)
        clh2=plotpc(net2.IW{1},net2.b{1},clh2);
    end
    %axis auto
    pause(0.7)
end

if ishandle(h)
delete(h)
end

msgbox('leanpn has completed!','warn')


% % % p1=[.7;-.2];
% % % t1=sim(net,p1);
% % % hold on
% % % 
% % % 
% % % ya=get(gca,'ylim');
% % % xa=get(gca,'xlim');
% % % plotpv(p1,t1);
% % % set(gca,'ylim',ya,'xlim',xa)
% % % 
% % % vh=findobj(gca,'type','line');
% % % set(vh(1),'color','red');
% % % disp('over!')