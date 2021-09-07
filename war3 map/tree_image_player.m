a=192/2*128;
[x,y]=meshgrid( -a:64:a );
v = x+1i*y;
r0 = abs(v+32+32i);
z = imag(log(v));
z0 = abs(mod(z,pi/10)-pi/20);
% imshow(z0,[])
%%
B=ones(size(v));
B(2:2:end,:)=0;
B(1:4:end,2:2:end)=0;
B(3:4:end,1:2:end)=0;
%
D=B;
D(r0>a+32)=0;
D(z0>0.11)=0; % pi/30+64/a
%
%% SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
r = 100*128;
z=(0:pi/10:2*pi-0.1);
xx = r*cos(z);
yy = r*sin(z);
M0=tree_FCN_hole(xx,yy,2368);
%%
%
tmp=[11008        9920        7872        5056        1728
    1728        5056        7872        9920       11008];
sx = tmp(1,:);
sy = tmp(2,:);
sxx = [sx,-sy,-sx,sy];
syy = [sy,sx,-sy,-sx];
M1=tree_FCN_hole(sxx,syy,576);
%
tmp=[11520       10624        8640        5824        2432
    1152        4672        7744       10048       11328];
gx = tmp(1,:);
gy = tmp(2,:);
gxx = [gx,-gy,-gx,gy];
gyy = [gy,gx,-gy,-gx];
M2=tree_FCN_hole(gxx,gyy,384);
%%
D(M1 | M2 | ~M0)=0;
imshow(D)
sum(D(:))
%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
treeP =  D;


