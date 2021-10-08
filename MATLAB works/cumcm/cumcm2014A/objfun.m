function objval=objfun(C_f,P_f,C_a,P_a,Tend)
%%
if ~nargin
    flag=1;
else
    flag=0;
end
r=1737.013e3;
%
H=r+15e3;%H=r+perigeeHeight;
m=2.4e3;
Vper=1692.7;
%
H_1=r+3e3;
vobj=57;
%%
if flag
%     C_f=0.899;P_f=5.005;C_a=0.902;P_a=1.787;
%     Tend=600;%假设的最长下降时间
%    C_f=0.291;P_f=7.661;C_a=0.563;P_a=3.260;
%    Tend=450;%假设的最长下降时间
      C_f=0.544;P_f=12439;C_a=0.228;P_a=0.824;
     Tend=500;%假设的最长下降时间  
end
%%
pN=300;%分300个点进行优化
tLine = linspace(0,Tend,pN);
%%
FN=7500-(tLine/Tend).^P_f*6000*C_f;%1500~7500
%FN=linspace(7500,1500,pN);%1500~7500

THETA=(tLine/Tend).^P_a*pi/2*C_a;
% THETA 是发动机和水平方向的夹角，水平方向本来就是随着陆器的飞行不断变化
% 水平方向的正方向为：j×e^{j*\THETA}
fn = FN.*sin(THETA); % Generate f(t)
ft = FN.*cos(THETA); % Generate g(t)
%%
Tspan = tLine;
IC = [H;0;0;Vper/H;m]; % y(t=0) = 1
[T,Y] = ode45(@(t,y) motion_ode(t,y,tLine,fn,tLine,ft),Tspan,IC); % Solve ODE
%%
if flag
myplotfcn(T,Y,tLine,FN,THETA,fn,ft)
%pause(0.04)
end
%%
mend=(m-Y(end,5))/m;
vend=abs(hypot(Y(end,3),Y(end,1).*Y(end,4))-vobj)/vobj;
pend=abs(Y(end,1)-H_1)/3e3;
objval=mend+vend+pend;
return
%%
r=1737.013e3;
n1=find(Y(:,1)<=r+3e3,1,'first');
%n2=find(Y(:,1)<r+2.4e3,1,'first');
switch isempty(n1)
    case false
        k=(Y(n1-1,1)-(r+3e3))/(Y(n1-1,1)-Y(n1,1));
        R=[1-k,k]*Y(n1-1:n1,:);
        tend=[1-k,k]*T(n1-1:n1,:)
        vend=abs(hypot(R(3),R(1).*R(4))-vobj)/vobj;
        mend=(m-R(5))/m;
        objval=mend+vend+vend^2;
    case true
        vend=abs(hypot(Y(end,3),Y(end,1).*Y(end,4))-vobj)/vobj;
        mend=(m-Y(end,5))/m;
        objval=Y(end,1)-(r+3e3)+mend+vend+vend^2;
end