a=192/2*128;
[xx,yy]=meshgrid( -a:64:a );
% x,y,r,1
v = xx+1i*yy;
r = abs(v);
z = imag(log(v));
z0 = abs(mod(z,pi/10)-pi/20);
imshow(z0,[])
%%
B=ones(size(xx));
B(2:2:end,2:2:end)=0;
B(r>a)=0;
r1= hypot(7936, 7936);
B(r<r1)=0;
B(z>pi/40)=0;



imshow(B)
sum(B(:))
%%
%[x,y]=meshgrid(0:1:a );
[x,y]=meshgrid(0:0.5:a );

r=sqrt(x.^2 + y.^2);
t=y./x;
C=zeros(size(r));
f=16;

h=87;
z= 7.5:15:50;
for k=z
    p=(y-h*sind(k))./(x-h*cosd(k));
    q=(y-f*sind(k))./(x-f*cosd(k));
    C(p>tand(k-31) & p<tand(k+31) & ...
     ( q<tand(k-2) | q>tand(k+2) ) )=1;
end
C(r<h ) =0;



h=64
z= 7.5:15:50;
for k=z
    p=(y-h*sind(k))./(x-h*cosd(k));
    q=(y-f*sind(k))./(x-f*cosd(k));
    C(p>tand(k-12) & p<tand(k+12) & ...
     ( q<tand(k-2) | q>tand(k+2) ) )=1;
end
C(r<h ) =0;

C(r>a-4 ) =0;

h=64
f=h-4
z= 7.5:15:50;
for k=z
    p=sqrt((x-h*cosd(k)).^2+(y-h*sind(k)).^2);
    q=sqrt((x-f*cosd(k)).^2+(y-f*sind(k)).^2);
    C(p<5.5 & q>2 & r<h )=1;
end

imshow(C)

