% Newton's method solve x^4=1
N=20;
n=2;
%n=3;
[x,y]=meshgrid(linspace(-n,n,600));
z=x+1i*y;

cont=zeros(size(z));
F=@(u) min([abs(u-1),abs(u+1),abs(u-1i),abs(u+1i)])<eps;%or<1
for k=1:N
z=3*z/4+1/4./z.^3;%Å£¶Ùµü´úÇó½âx^4=1;
cont=cont+arrayfun(F,z);
end
%%
imagesc(cont)
title('x^4-1=0');
figure
colormap(hsv)
imagesc(angle(z))
title('x^4-1=0');