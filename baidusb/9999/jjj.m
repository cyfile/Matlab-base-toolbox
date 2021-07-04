% lorenz

a=16;
b=4;
c=45;

mylorenz=@(t,x)[a*(x(2)-x(1));...

                          c*x(1)-x(1)*x(3)-x(2);...
                          x(1)*x(2)-b*x(3)];
                     
[t,x]=ode45(mylorenz,[0,30],[12,4,0]);

plot3(x(:,1),x(:,2),x(:,3))
xlabel('x');ylabel('y');zlabel('z');




%%matlab自带的有lorenz.m文件可以直接打开

%   >>lorenz↓ 