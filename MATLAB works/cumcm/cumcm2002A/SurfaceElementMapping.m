% 面元映射
%% 
syms l phi theta  vx vy vz real
%%
%绕y轴旋转变换阵
Ry=[cos(theta) 0 sin(theta);...
    0      1      0     ;...
    -sin(theta) 0  cos(theta)]
%绕z轴旋转变换阵
Rz=[ cos(phi) -sin(phi) 0;...
    sin(phi) cos(phi) 0;...
    0         0    1]
%Ry*Rz  %V~=Ry*Rz*v
Rz*Ry %V=Rz*Ry*v 对[0 0 1]进行旋转变换
T=[ cos(phi)*cos(theta), -sin(phi), cos(phi)*sin(theta);
    sin(phi)*cos(theta),  cos(phi), sin(phi)*sin(theta);
    -sin(theta),         0,          cos(theta)];
% 因为
vx=sin(theta)*cos(phi);
vy=sin(theta)*sin(phi);
vz=cos(theta);
% 并且考虑到 theta 属于[0,pi],cos(theta)>=0 sin(theta)>=0
% 则有 sin(theta)=sqrt(1-vz*vz)
T = [vx*vz/sqrt(1-vz*vz), -vy/sqrt(1-vz*vz), vx;
    vy*vz/sqrt(1-vz*vz),  vx/sqrt(1-vz*vz), vy;
    -sqrt(1-vz*vz),                0 , vz];

T=@(vx,vy,vz) [vx*vz/sqrt(1-vz*vz), -vy/sqrt(1-vz*vz), vx;...
    vy*vz/sqrt(1-vz*vz),  vx/sqrt(1-vz*vz), vy;...
    -sqrt(1-vz*vz),                0 , vz];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 画图
[X,Y,Z] = sphere(10);
mesh(X,Y,Z,'edgecolor','c')
hold on
%
plot3(0,0,1,'ro')
theta=[0.1 0.1 0.1 0.1];phi=[0 pi/2 pi 3*pi/2];
x=sin(theta).*cos(phi);
y=sin(theta).*sin(phi);
z=cos(theta);
plot3(x,y,z,'o')
%
theta=0.5+rand;phi=rand*2*pi;
vx=sin(theta)*cos(phi);
vy=sin(theta)*sin(phi);
vz=cos(theta);
plot3(vx,vy,vz,'ro')
XYZ=T(vx,vy,vz)*[x;y;z];
plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'o')

