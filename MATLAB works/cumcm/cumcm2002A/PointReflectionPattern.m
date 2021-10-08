%% 点光源直射,反射图样
close all,clear,clc
L=5;
%L=3.8120;
n=4*10+1;
%%
p=36*36/21.6/2;
c=p/2;
%f=@(y,z) (y.*y+z.*z)/2/p;
%%
figure
% set(gca,'ColorOrder',hsv((n-1)/4)) %有时无效,因为:
% high-level functions like plot and plot3 reset most axes properties
% (including ColorOrder) to the defaults each time you call them
% By default, NextPlot is set to replace, which is equivalent to a cla reset command .
% If you set NextPlot to replacechildren,
% set(gca,'NextPlot','replacechildren')
% MATLAB deletes the axes children, but does not reset axes properties. This is equivalent to a cla command without the reset.
set(gcf,'DefaultAxesColorOrder',hsv((n-1)/4))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
Theta = linspace(-pi,pi,21)';
R = linspace(0,36,7);
Z = cos(Theta)*R;
Y = sin(Theta)*R;
X = (Z.^2+Y.^2)/60;
%
subplot(121)
hold on
mesh(X,Y,Z,'FaceAlpha',0.5,'EdgeColor','k')
axis tight
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 初始光点
x=c;
y=L;
z=0;
%% 入射单位向量
phi = linspace(0,2*pi,n);
theta = linspace(0,pi,n)';

weight_color=kron(sin(theta),[1,2/4,1/5]);% d_S=sin(theta)*d_theta*d_phi

vx=sin(theta)*cos(phi);
vy=sin(theta)*sin(phi);
vz=repmat(cos(theta),1,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 直射面元图像
XP_d=2500*ones(n,n);%少个零(缩小10倍)
m=XP_d./vx;
YP_d=y+m.*vy;ZP_d=z+m.*vz;
%
ind=abs(YP_d)>3e3 | abs(ZP_d)>3e3;
YP_d(ind)=nan;ZP_d(ind)=nan;
%
subplot(222)
plot(YP_d/10,ZP_d/10)
hold on
set(gca,'ColorOrder',1-weight_color)
plot(YP_d'/10,ZP_d'/10)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 反射面元图像
%vy=vy((n+1)/2,(n+1)/2),vz=vz((n+1)/2,(n+1)/2),vx=vx((n+1)/2,(n+1)/2),
k = (30*vx + (900*vx.^2 - 60*y*vx.*vy + 900*vy.^2 - vz.^2*y.^2 + 900*vz.^2).^(1/2) - vy*y)./(vy.^2 + vz.^2);
ind=abs(vy)<0.01 & abs(vz)<0.01 & vx<0;%分母接近0时直接算
%mesh(double(ind))
k(ind)=15-L*L/60;

%%
x=x+k.*vx;y=y+k.*vy;z=z+k.*vz;
ind=x>21.6;
x(ind)=nan;y(ind)=nan;z(ind)=nan;
%
subplot(121)
plot3(x,y,z,'-o')
view(30,40)
%% 镜面上点的单位法向量
nvx=-60./sqrt(3600+4*y.*y+4*z.*z);
nvy=2*y./sqrt(3600+4*y.*y+4*z.*z);
nvz=2*z./sqrt(3600+4*y.*y+4*z.*z);

%% 反射光线向量
tmp_a=2*(vx.*nvx+vy.*nvy+vz.*nvz);
vx=vx-tmp_a.*nvx;
vy=vy-tmp_a.*nvy;
vz=vz-tmp_a.*nvz;

%%
m=(25000+c-x)./vx;
YP=y+m.*vy;ZP=z+m.*vz;
%%
subplot(224)
hold on
set(gca,'NextPlot','add')
set(gca,'ColorOrder',1-weight_color)
plot(YP',ZP')
set(gca,'ColorOrder',hsv((n-1)/4))
plot(YP,ZP)
%%
figure
hold on
set(gca,'NextPlot','add')
set(gca,'ColorOrder',1-weight_color)
plot(YP',ZP')
set(gca,'ColorOrder',hsv((n-1)/4))
plot(YP,ZP)

plot(YP(:,[1,21]),ZP(:,[1,21]),'r','linewidth',2)
plot(YP(:,[11,31]),ZP(:,[11,31]),'r','linewidth',2)
title('横轴[0 2.6e3]部分始终都只有一块蓝面覆盖,这说明仅有水平反射的光线射入该区域')
%
a=[1:n,1];
b=[2:n,1,2];
k=1;
h1=plot(YP(:,[a(k),b(k)]),ZP(:,[a(k),b(k)]),'b',...
    'YDataSource','ZP(:,[a(k),b(k)])','XDataSource','YP(:,[a(k),b(k)])',...
    'linewidth',2);
h2=plot(YP(:,[a(k),b(k)])',ZP(:,[a(k),b(k)])','b',...
    'YDataSource','transpose(ZP(:,[a(k),b(k)]))','XDataSource','transpose(YP(:,[a(k),b(k)]))',...
    'linewidth',2);
while 1
    for k=2:n+1
        refreshdata(h1,'caller')
        refreshdata(h2,'caller')
        drawnow
        pause(0.05)
    end
end










