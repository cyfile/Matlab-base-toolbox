a=192/2;
[x,y]=meshgrid( -a:a );
v = x+1i*y;
r = abs(v);
z = imag(log(v));
z0 = mod(z,pi/10);
z1 = pi/20;
%%
B=zeros(size(x));
k=12:16:a+16;
for m=k
        B(z0>=z1 & r >=m & r<m+8)=2;
        B(z0<z1  & r >=m+8 & r< m+16)=2;
end        
%%
B( r >19.5 & r<20.5)=5;
B( r >39.5 & r<40.5)=5;
%%
groundType=B;
% image(B),axis equal
% imshow(B,[])




