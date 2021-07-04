% BP001
% [x,t] = simplefit_dataset;
clear

x=[1 2;-1 1;-2 1;-4 0]';
t=[.2 .8 .8 .2];
qq = feedforwardnet(5);
qq.layers{2}.transferFcn='logsig';
qq.trainParam.goal=0.001;
[qq,tr] = train(qq,x,t);
plotperform(tr)
% view(qq)
y = qq(x);
perf = perform(qq,y,t);
figure

plot(t,'r')
hold on
plot(y,'s','MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10)