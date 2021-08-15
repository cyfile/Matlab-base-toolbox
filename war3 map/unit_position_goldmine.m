% 192/2*128==12288;
k=0;
x=8704-k*64;y=7744+k*64; 
r = hypot(x ,y);% 11904 ,1024
z = (0:pi/10:pi/2-0.1)+ atan(y/x)-pi/5;
xy =r * [cos( z ); sin( z )];
% mod(xy+eps(1e3),64)
tmp=round(xy/64)*64
%%
tmp =[11584       10688        8704        5888        2496
    1152        4672        7744       10048       11392];
[x0,y0]=meshgrid(-128:64:128);
x = tmp(1,:)+x0(:);
y = tmp(2,:)+y0(:);
r=hypot(x,y);
z=atan(y./x)-(0:pi/10:pi/2-0.1);
plot(r,z,'*')
%%
ind=0.099<z & z<0.1035 & 1.157e4<r & r<1.162e4;
goldLocation=[x(ind),y(ind)]'