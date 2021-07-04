% lyapunov function 01.jpg 02.jpg

clear
[x,y]=meshgrid(-10:.1:10);
z=(8*x.*x+4*x.*y+y.*y)/2;
contour(x,y,z,logspace(log10(.2),3,11))
colormap cool
% )];

axis([-12,12,-12,12])
 hold on
 x0y=[-10*ones(1,21);-10:10]';
 x0=[flipud(x0y);fliplr(x0y)];
 plot(x0(:,1),x0(:,2),'r.','LineWidth',5)
 
% set(gca,'colororder',cool(10));
for xx=x0'
[t,xt]=ode45(myode,[0,20],xx);%20 可以更大，但x始终趋于[0;0]
                                              %而且无论初值xx取什么。
                                              %这说明零解x=[0;0],是方程的稳定解。
plot(xt(:,1),xt(:,2),'b')
pause(.5)
end

figure
% mesh(x,y,z)

 

syms xs ys
V=(8*xs.*xs+4*xs.*ys+ys.*ys)/2;
ezmesh(V)                                  %可以观察到V函数是定正的。
hold on
f1=ys;
f2=-2*xs-3*ys;
dVdt=simplify(diff(V,xs)*f1+diff(V,ys)*f2) %可以看到dVdt也是定负的
                                                           %故零解稳定
ezmesh(dVdt)

ezmesh('0*x+0*y')  
colormap cool