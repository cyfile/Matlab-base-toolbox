% twodimensionalSOM
% % Neural Network Toolbox
% %   Version 7.0.2 (R2011b) 08-Jul-2011

% Create inputs X.
bounds = [0 1; 0 1];   % Cluster centers to be in these bounds.
clusters = 8;          % This many clusters.
points = 10;           % Number of points in each cluster.
std_dev = 0.05;        % Standard deviation of each cluster.
x = nngenc(bounds,clusters,points,std_dev);

% Plot inputs X.
fh=figure;
plot(x(1,:),x(2,:),'+r');
title('Input Vectors');
xlabel('x(1)');
ylabel('x(2)');
hold on


net = selforgmap([3,3]);
net = configure(net,x);
figure
plotsompos(net)
figure(fh)
net.trainParam.epochs = 4;
net.trainParam.showWindow=0;
for m=1:10
net = train(net,x);

lh=plot(net.iw{1}(:,1),net.iw{1}(:,2),'o');
pause(.5)
set(lh,'Color',[.1,0.2,0.3],'Marker','.')
end
lh=plot(net.iw{1}(:,1),net.iw{1}(:,2),'o');

figure
plotsompos(net,x)
figure(fh)
plotsom(net.iw{1},net.layers{1}.distances)