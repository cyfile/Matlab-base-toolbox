% decomandrecon

%decomposition reconstrction
t=linspace(0,1,2^8);
f=sin(4*pi*t)+1/2*cos(10*pi*t);
h=figure;
%-------------------------------------------------------
subplot(621)
plot(t,f)
hold on

subplot(622)
[c,l] = wavedec(f,3,'haar');
plot(c)

subplot(621)
[nc,nl]=upwlev(c,l,'haar');
nt=linspace(0,1,nl(1));
plot(nt,nc(1:nl(1)),'k')

subplot(624)
c2=c;
c2(abs(c)<0.2*max(c))=0;
hold on
plot(c2,'r')

subplot(623)
[nc2,nl2]=upwlev(c2,l,'haar');
plot(nt,nc2(1:nl2(1)),'r')

subplot(626)
c3=c;
c3(abs(c)<0.1*max(c))=0;
plot(c3,'g')

subplot(625)
[nc3,nl3]=upwlev(c3,l,'haar');
plot(nt,nc3(1:nl3(1)),'g')
%------------------------------
%%%%%%%%%%%%%%%%
%------------------------------------------------------------
subplot(627)
plot(t,f)
hold on

subplot(628)
[c,l] = wavedec(f,3,'db2');
plot(c)

subplot(627)
[nc,nl]=upwlev(c,l,'db2');
nt=linspace(0,1,nl(1));
plot(nt,nc(1:nl(1)),'k')

subplot(6,2,10)
c2=c;
c2(abs(c)<0.2*max(c))=0;
hold on
plot(c2,'r')

subplot(6,2,9)
[nc2,nl2]=upwlev(c2,l,'db2');
plot(nt,nc2(1:nl2(1)),'r')

subplot(6,2,12)
c3=c;
c3(abs(c)<0.1*max(c))=0;
plot(c3,'g')

subplot(6,2,11)
[nc3,nl3]=upwlev(c3,l,'db2');
plot(nt,nc3(1:nl3(1)),'g')

ax=get(h,'children');
set(ax,'XTickLabel','','yTickLabel','','box','off')