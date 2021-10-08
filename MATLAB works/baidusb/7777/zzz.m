% competlayerandSOM
% % Neural Network Toolbox
% %   Version 7.0.2 (R2011b) 08-Jul-2011


angles = 0:0.5*pi/99:0.5*pi;
X = [sin(angles); cos(angles)];
plot(X(1,:),X(2,:),'+r')
hold on
netc = competlayer(10);
netc = configure(netc,X);
netc.trainParam.epochs = 3;
netc.trainParam.showWindow=0;
for m=1:10
% plotvec(netc.iw{1}',3*ones(1,10),'+')
plot(netc.iw{1}(:,1),netc.iw{1}(:,2),'+')   
netc = train(netc,X);
pause(1)
end

% net = competlayer(8,.1);
% netc = configure(netc,X);

nets = selforgmap(10);

nets.trainParam.epochs = 1;
nets.trainParam.showWindow=0;
for m=1:20
% plotvec(nets.iw{1}',4*ones(1,10),'.')   
plot(nets.iw{1}(:,1),nets.iw{1}(:,2),'g.')   

nets = train(nets,X);
pause(.5)
end
figure
plotsompos(nets)
% gensim(nets)
% view(nets)