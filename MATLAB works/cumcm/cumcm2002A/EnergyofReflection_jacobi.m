% 利用雅克比 解析计算反射强度 (算不下去了)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
clear,clc
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

vx=sin(theta)*cos(phi);
vy=sin(theta)*sin(phi);
vz=cos(theta);
ve_in=[vx,vy,vz];

%%
syms k positive
k=solve( 60*(x+vx*k)==(y+vy*k)^2+(z+vz*k)^2,k );
pretty(simplify(k));
k=k(1);%取大值

%%
x=x+k*vx;y=y+k*vy;z=z+k*vz;
%assume(60*x==y^2+z^2)
v_nor=[60,-2*y,-2*z]/2;

%%
vX=25e3+C-x;
vY=Y-y;
vZ=Z-z;
v_out=[vX,vY,vZ];
% vX=25e3;
% vY=Y;
% vZ=Z;

veX=vX/sqrt(vX*vX+vY*vY+vZ*vZ);
veY=vY/sqrt(vX*vX+vY*vY+vZ*vZ);
veZ=vZ/sqrt(vX*vX+vY*vY+vZ*vZ);


%%
% 共面条件
%F= simplify(det([vx,vy,vz;vX,vY,vZ;v_nor]));
F= simplify(det([ve_in;v_out;v_nor]));
% 投影相等条件
%G= [vx+veX,vy+veY,vz+veZ]*v_nor';
G= simplify((ve_in*v_nor.')*(v_out*v_out.')+(v_out*v_nor.'));
return
%%
% a=(det(jacobian([F,G], [theta,Y]))*det(jacobian([F,G],[Z,phi]))-...
%     det(jacobian([F,G], [theta,Z]))*det(jacobian([F,G],[Y,phi])))/...
%     ( det(jacobian([F,G], [Y,Z])))^2;
% simplify(a)
b=det(jacobian([F,G],[phi,theta]))/det(jacobian([F,G],[Y,Z]));
JC=simplify(subs(b,{Y,Z},{2.6e3,0}));
JB=simplify(subs(b,{Y,Z},{1.3e3,0}));

% dYdZ=J*dphi*dtheta
% dYdZ=J/sin(theta)*sin(theta)*dphi*dtheta=J/sin(theta);
% 能量与面积成反比
% EYZ=sin(theta)/J
%%%%%%%%%%%%%%%%%%%%%%%%%%







