% comlayer
bounds = [0 1; 0 1];   % Cluster centers to be in these bounds.
clusters = 8;          % This many clusters.
points = 10;           % Number of points in each cluster.
std_dev = 0.05;        % Standard deviation of each cluster.
x = nngenc(bounds,clusters,points,std_dev);

% Plot inputs X.
hf=figure;
plot(x(1,:),x(2,:),'+r');
title('Input Vectors');
xlabel('x(1)');
ylabel('x(2)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

net2 = competlayer(8,.1);

net = configure(net2,x);
net.trainParam.showWindow = 0;

% gensim(net)
w = net.IW{1};
% plot(x(1,:),x(2,:),'+r');
hold on;
hl=plot(w(:,1),w(:,2),'ob','xdatasource','w(:,1)','ydatasource','w(:,2)');

net.trainParam.epochs = 1;
a=nntraintool;
set(a,'minimized','on')
for n=1:10
net = train(net,x);

% shg
% figure(gcf)
% figure(hf)
w = net.IW{1};
refreshdata(hl,'caller') % Evaluate y in the function workspace
drawnow; pause(.5)
end
set(a,'minimized','off')