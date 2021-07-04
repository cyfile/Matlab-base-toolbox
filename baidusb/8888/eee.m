% underandoverlappingRBF
P = -1:.1:1;
T = [-.9602 -.5770 -.0729  .3771  .6405  .6600  .4609 ...
      .1336 -.2013 -.4344 -.5000 -.3930 -.1647  .0988 ...
      .3072  .3960  .3449  .1816 -.0312 -.2189 -.3201];

hf=figure;
sa=subplot(321);
sap=get(sa,'position');
plot(P,T,'+');
title('Training Vectors');
xlabel('Input Vector P');
ylabel('Target Vector T');

sa2=subplot(323);
sap2=get(sa2,'position');
delete(sa2)

sa3=subplot(325);
sap3=get(sa3,'position');
delete(sa3)

sa2=copyobj(sa,gcf);
set(sa2,'position',sap2);
sa3=copyobj(sa,gcf);
set(sa3,'position',sap3);
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
eg = 0.02; % sum-squared error goal
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

sa=subplot(322);
sap=get(gca,'position');
sc = 1;  % spread constant
net = newrb(P,T,eg,sc);
hnf=gcf;
set(gca,'position',sap);
h=gca;
figure(hf);
copyobj(h,gcf);
delete(sa)
delete(hnf)
%--------------------------------------------------------
subplot(321)

X = -1:.01:1;
Y = net(X);
hold on;
plot(X,Y);
hold off;
legend({'Target','Output'})
%%%%%%%%%%
%%%%%%%%%%
sa=subplot(324);
sap=get(gca,'position');
sc =0.01;  % spread constant
net = newrb(P,T,eg,sc);
hnf=gcf;
set(gca,'position',sap);
h=gca;
figure(hf);
copyobj(h,gcf);
delete(sa)
delete(hnf)
%--------------------------------------------------------
subplot(323)

X = -1:.01:1;
Y = net(X);
hold on;
plot(X,Y);
hold off;
legend({'Target','Output'})
%%%%%%%%%%%%%%%%%%%%%
sa=subplot(326);
sap=get(gca,'position');
sc = 100;  % spread constant
net = newrb(P,T,eg,sc);
hnf=gcf;
set(gca,'position',sap);
h=gca;
figure(hf);
copyobj(h,gcf);
delete(sa)
delete(hnf)
%--------------------------------------------------------
subplot(325)

X = -1:.01:1;
Y = net(X);
hold on;
plot(X,Y);
hold off;
legend({'Target','Output'})