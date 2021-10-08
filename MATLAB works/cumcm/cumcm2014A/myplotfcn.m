function myplotfcn(T,Y,tLine,FN,THETA,fn,ft)
%%
r=1737.013e3;
perigeeHeight=15e3;
apogeeHeight=100e3;
vobj=57;
%%
n0=1;
n1=find(Y(:,1)<r+3e3,1,'first');
n2=find(Y(:,1)<r+2.4e3,1,'first');
%%
clf
subplot(421)
plotyy(tLine,FN,tLine,THETA)
set(gca,'xgrid','on','xtick',tLine([n0,n1,n2]),'xticklabel',[])
title('总推力(FN) & 总推力与水平面的夹角(\Theta)');
%xlabel('Time');
%%
subplot(422)
plotyy(tLine,fn,tLine,ft)
set(gca,'xgrid','on','xtick',tLine([n0,n1,n2]),'xticklabel',[])
title('径向的分推力(fn) & 水平方向的分推力(ft) ');
xlabel('Time');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
subplot(423)
[AX,hLine1,hLine2]= plotyy(T, Y(:,1),T,Y(:,3));
set(hLine2,'LineStyle','--')
hold(AX(1))
plot(AX(1),T,r*ones(size(T)),'r')
ylim([r-perigeeHeight r+perigeeHeight+perigeeHeight]);
set(gca,'xgrid','on','xtick',tLine([n1,n2]),'xticklabel',[])
title({'相对月球的' '径向位置(R) & 径向线速度(R\prime=v_r)'});
%xlabel('Time');
%%
subplot(424)
plotyy(T,Y(:,2),T,Y(:,4))
title({'相对月球的' '着陆器角位置(\theta) & 着陆器角速度(\theta\prime)'});
xlabel('Time');
%%
subplot(425)
plotyy(T,Y(:,3),T,Y(:,1).*Y(:,4))
title('垂直速度(v_r=R\prime) & 水平速度(v_t=R*\theta\prime)');
xlabel('Time');
%%
subplot(426)
semilogy(T,hypot(Y(:,3),Y(:,1).*Y(:,4)))
hold on
plot(T,vobj*ones(size(T)),'r');
title('总速度(v)');
xlabel('Time');
%%
subplot(427)
plot(T,Y(:,5))
title('着陆器质量(m)');
xlabel('Time');
%%
subplot(428)
plot(Y(:,1).*exp(1j*Y(:,2)))
hold on
plot(r*exp(1j*linspace(0,pi/10,100)),'r');
title('下降轨道');
%%
