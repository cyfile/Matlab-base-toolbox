% Varianceandmean
n=2;
scale=1;
x=rand(n,1);
quiver(0,0,x(1),x(2),scale)
hold on
axis equal
var(x,1)
x_=repmat(mean(x),n,1);
quiver(x(1),x(2),-x_(1),-x_(2),scale)
xsubx_=x-x_
quiver(0,0,xsubx_(1),xsubx_(2),scale)
Dx=norm(xsubx_)^2/n

Ex2=norm(x)^2/n

Ex_2=norm(x_)^2/n

x_'*xsubx_