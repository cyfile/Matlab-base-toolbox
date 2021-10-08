%% 空间随机方向的生成(验证图)
N=1000;

theta=2*pi*rand(N,1);
vz0=2*rand(N,1)-1;vx0=sqrt(1-vz0.^2).*cos(theta);vy0=sqrt(1-vz0.^2).*sin(theta);

[X,Y,Z] = sphere(10);
hold on
axis equal
mesh(X,Y,Z)
plot3(vx0,vy0,vz0,'o')
%%
set(gcf,'Renderer','OpenGL')
