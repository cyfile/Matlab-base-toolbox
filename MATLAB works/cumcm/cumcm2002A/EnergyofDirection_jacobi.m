% 利用雅克比 解析计算直射强度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
P=36*36/21.6/2;
C=P/2;
%fx=@(y) (y.*y)/2/P;
%%
syms l phi theta Y Z real
% assume(phi > -pi/2 & phi < pi/2)
% assume(theta > 0 & theta < pi)

x=C;
y=l;
z=0;

vX=25e3+C-x;
vY=Y-y;
vZ=Z-z;

veX=vX/sqrt(vX*vX+vY*vY+vZ*vZ);
veY=vY/sqrt(vX*vX+vY*vY+vZ*vZ);
veZ=vZ/sqrt(vX*vX+vY*vY+vZ*vZ);

%theta=pi/2;
vx=sin(theta)*cos(phi);
%vx=cos(phi)
vy=sin(theta)*sin(phi);
%vy=sin(phi)
vz=cos(theta);
%vz=0;
%%
F= vx-veX;
G= vz-veZ;
%%
% a=(det(jacobian([F,G], [theta,Y]))*det(jacobian([F,G],[Z,phi]))-...
%     det(jacobian([F,G], [theta,Z]))*det(jacobian([F,G],[Y,phi])))/...
%     ( det(jacobian([F,G], [Y,Z])))^2;
% simplify(a)
b=det(jacobian([F,G],[phi,theta]))/det(jacobian([F,G],[Y,Z]));
assume(F==0 & G==0 )%& vy==veY
J0=simplify(b)
J=(Y^2 - 2*Y*l + Z^2 + l^2 + 625000000)/cos(phi);
%dYdZ=J*dphi*dtheta
% dYdZ=J/sin(theta)*sin(theta)*dphi*dtheta=J/sin(theta);
% 能量与面积成反比
% EYZ=sin(theta)/J
%%%%%%%%%%%%%%%%%%%%%%%%%%
%因为
%theta=pi/2;
%cos(phi)=vx=veX
E_YZL=subs(1/J,cos(phi),veX);
JC=simplify(subs(E_YZL,{Y,Z},{2.6e3,0}));
int(JC,l,-l,l)
Ec_d=@(l) 25000/((l - 2600)^2 + 625000000)^(3/2);
%q = integral(Ec_d,-1,1)
JB=simplify(subs(E_YZL,{Y,Z},{1.3e3,0}));
Eb_d=@(l) 25000/((l - 1300)^2 + 625000000)^(3/2);


