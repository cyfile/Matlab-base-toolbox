% XYƽ�淴�仭ͼ 
%%
clear,clc
C=15;
N=37;
%%
y=linspace(-36,36,N);
x=y.*y/60;
plot(x,y)
hold on
%%
x_c=25e3+C;
y_c=2.6e3;

% vx_nor=-60;
% vy_nor=2*y;
vex_nor=60./sqrt(60*60+4*y.*y);
vey_nor=-2*y./sqrt(60*60+4*y.*y);
quiver(x,y,-vex_nor,-vey_nor)
%%
vx_out=x_c-x;
vy_out=y_c-y;
n=(100-x)./vx_out;
Y0=y+n.*vy_out;
plot(100,Y0,'or')
plot([x;100*ones(1,N)],[y;Y0],'m')
%%
tempk=2*(vx_out.*vex_nor+vy_out.*vey_nor);
vx_in=tempk.*vex_nor-vx_out;
vy_in=tempk.*vey_nor-vy_out;
%
m=(C-x)./vx_in;
Y=y+m.*vy_in;
plot(C,Y,'or')
plot([x;C*ones(1,N)],[y;Y],'m')
axis equal