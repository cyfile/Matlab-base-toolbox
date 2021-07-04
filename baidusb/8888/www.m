% linearlayer

close all
clc
clear
figure
cla
p=[1,-1.2];
t=[.5,1.0];
w=-1:.1:1;
b=-1:.1:1;
es=errsurf(p,t,w,b,'purelin');

% subplot(211)
plotes(w,b,es)

% neto=newlind(p,t);
%
% a=sim(neto,p)
% sse=sumsqr(t-a)
% plotep(neto.IW{1},neto.b{1},sse);

net=newlin([-2 2],1,[0],.4*maxlinlr(p,'bias'))
net.trainparam.goal=.001;
net.trainparam.epochs=1;
h=text(.5*sum(get(gca,'xlim')),.5*sum(get(gca,'ylim')),'*click on me*');
set(h,'horizontal','center','fontweight','bold');
[net.IW{1} net.B{1}]=ginput(1);
delete(h);

tr.perf(1)=1;
while(tr.perf(end)>.001)
[net,tr]=train(net,p,t);
plotep(net.iw{1},net.b{1},sumsqr(t-sim(net,p)))
pause(0.5)
end

%
% subplot(212)
% plotperf(tr,net.trainparam.goal)
% net=init(net);
% net.adaptParam.passes=1;
% clh=plotpc(net.IW{1},net.b{1});
%
%
% e=1;
%
% while(sse(e))
%     [net,y,e]=adapt(net,p,t);
%     clh=plotpc(net.IW{1},net.b{1},clh);
%     %axis auto
%     pause(0.7)   
% end
%
% p1=[.7;-.2];
% t1=sim(net,p1);
% hold on
%
%
% ya=get(gca,'ylim');
% xa=get(gca,'xlim');
% plotpv(p1,t1);
% set(gca,'ylim',ya,'xlim',xa)
%
% vh=findobj(gca,'type','line');
% set(vh(1),'color','red');
disp('over!')