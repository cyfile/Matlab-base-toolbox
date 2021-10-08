%%
M=7.3477e22;%月球质量
G=6.674e-11;%万有引力常量，来自http://en.wikipedia.org/wiki/Gravitational_constant
m=2.4e3;%着陆器质量
%%
r=1737.013e3;
perigeeHeight=15e3;
apogeeHeight=100e3;
A=r+perigeeHeight/2+apogeeHeight/2;
C=A-r-perigeeHeight;
B=sqrt(A^2-C^2);
H=r+perigeeHeight;
H2=r+apogeeHeight;
% A =1794513;
% B =1794009;
% C =42500;
% H =1752013;
% H2 =1837013;
%% 
%椭圆轨道(着陆准备轨道)近月点和远月点的速度
Vper=B*sqrt(G*M/A/(A-C)^2)%近月点速度1692.7
Vapo=B*sqrt(G*M/A/(A+C)^2)%远月点速度1614.4
%%
%着陆器在近月点和远月点作匀速圆周运动时的速度
V_con=sqrt(G*M/(r+perigeeHeight))%1673
sqrt(G*M/(r+apogeeHeight))
%%
%以近月点速度在近月点轨道，匀速圆周运动时
%由发动机提供的的向心加速度
a=Vper^2/H-G*M/H^2;
%由发动机提供的推力
F_add=a*m
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_1=r+3e3;
H_2=r+2.4e3;
H_3=r+100;
%在H_2点着陆器所受月球的重力
G*M/H_2^2*m
G*M/H_3^2