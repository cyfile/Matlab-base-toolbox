a=192/2;
[x,y]=meshgrid( -a:a );
v = x+1i*y +0.5+0.5i; % shadow textures positioned by tile center not tile corners
r = abs(v);
z = imag(log(v));

C=zeros(size(x));
z0 = abs( mod(z+pi/20,pi/10)-pi/20 );
% imshow(z0,[])
m = 54; % m_old=1024*8/128;m_old*5/6;
%%
z1 = pi/20 - 6/2/m; 
C(z0 < z1 & m<=r & r<m+4 ) =1;
%
L=[m+4:4:a-1 a];
n=length(L)-1;
R=[4 6 8 8 10*ones(1,n-4) ];
for k= 1:n
    C( z0 < R(k)/2/L(k) & L(k)<=r & r<L(k+1) ) =1;
end
%
C( a-1<=r & r<a+7 ) =1;
%%
% imshow(~C,[])
% imshow(C,[])
isBoundary = C;



