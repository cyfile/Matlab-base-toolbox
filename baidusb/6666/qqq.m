% 二元函数极值点程序
clear
close all
[x,y] = meshgrid(1:20,1:20);
fx=y.*x.^2+y.*x+y.^3+3;
waterfall(x,y,fx)

 

hold on

 

[peak,ind]=max(fx(:));
[maxx,maxy]=ind2sub([20,20],ind)
plot3(maxx,maxy,peak,'ro','markersize',15)

 

[peaks,inds]=max(fx');
plot3(inds,1:20,peaks,'b.','markersize',20)

 

%ezmesh('y.*x.^2+y.*x+y.^3+3',[1,20,1,20])