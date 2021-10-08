%test ode
m=2.4e3;%着陆器质量
r=1737.013e3;
perigeeHeight=15e3;
%
V_con =1673;
%
Vper=1692.7;
F_add =90.806415519263169;
%%
pN=500;
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------着陆准备轨道-----------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tend=7000;
tLine = linspace(0,Tend,pN); 
FN=linspace(0,0,pN);%1500~7500
k=8;
THETA=pi/4*(1-cos(logspace(-3,log10(k*pi/2),pN)));
fn = FN.*sin(THETA); % Generate f(t)
ft = FN.*cos(THETA); % Generate g(t)
%
Tspan = linspace(0,Tend,pN);
IC = [r+perigeeHeight;0;0;Vper/(r+perigeeHeight);m]; 
%
[T,Y] = ode45(@(t,y) motion_ode(t,y,tLine,fn,tLine,ft),Tspan,IC); % Solve ODE
myplotfcn(T,Y,tLine,FN,THETA,fn,ft)
%
%subplot(423)可以看出远月点的位置
%subplot(4,2,5:6)可以看出远月点的速度
%subplot(4,2,8)可以看出椭圆轨道
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------近月点以V_con做匀速圆周运动------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tend=4000;
tLine = linspace(0,Tend,pN); 
FN=linspace(0,0,pN);%1500~7500
k=8;
THETA=pi/4*(1-cos(logspace(-3,log10(k*pi/2),pN)));
fn = FN.*sin(THETA); % Generate f(t)
ft = FN.*cos(THETA); % Generate g(t)
%
Tspan = linspace(0,Tend,pN);
IC = [r+perigeeHeight;0;0;V_con/(r+perigeeHeight);m]; 
%
[T,Y] = ode45(@(t,y) motion_ode(t,y,tLine,fn,tLine,ft),Tspan,IC); % Solve ODE
myplotfcn(T,Y,tLine,FN,THETA,fn,ft)
%
%subplot(423)可以看出运动轨迹为一个正圆
%subplot(4,2,5:6)可以看出线速度恒定
%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------近月点试图以Vper做匀速圆周运动---------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%F_add =90.806;
Tend=4000;
tLine = linspace(0,Tend,pN); 
FN=linspace(F_add,F_add,pN);%1500~7500
k=8;
THETA=-pi/2;
fn = FN.*sin(THETA); % Generate f(t)
ft = FN.*cos(THETA); % Generate g(t)
%
Tspan = linspace(0,Tend,pN);
IC = [r+perigeeHeight;0;0;Vper/(r+perigeeHeight);m]; 
%
[T,Y] = ode45(@(t,y) motion_ode(t,y,tLine,fn,tLine,ft),Tspan,IC); % Solve ODE
myplotfcn(T,Y,tLine,FN,THETA,fn,ft)
%
%subplot(423)可以看到最开始着陆器高度不变，随后高度持续下降
%subplot(4,2,5:6)可以看出着陆器没能维持多久的匀速运动，速度持续增加
%subplot(4,2,7)可以看出原因是着陆器的质量持续下降
%              即通过恒力F_add不能使着陆器维持匀速圆周运动






