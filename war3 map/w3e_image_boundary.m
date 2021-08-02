a=192/2;
[x,y]=meshgrid( -a:a );
v = x+1i*y +0.5+0.5i; % shadow textures positioned by tile center not tile corners
r = abs(v);
z = imag(log(v));

z0 = abs( mod(z+pi/20,pi/10)-pi/20 );
% imshow(z0,[])
C=zeros(size(x));
m=1024*8/128;
m = 54; % m*5/6;
%%
z1 = pi/20 - 6/2/m;
C(z0 < z1 & m<=r & r<m+4 ) =1;
%%
% (y-1.8)/(x-m)=(1.3-1.8)/(a-m)
l = z0.*((r-m)*-0.4/(a-m) + 1.8);
C(l < pi/40  & m+2<r & r<a+2  ) =1;
%%
C( a+1<=r & r<a+6 ) =1;
%%

imshow(C,[])
isBoundary = C;



