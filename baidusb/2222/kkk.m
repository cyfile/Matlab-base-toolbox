% 用最小的圆包围随机产生的点
http://www.ilovematlab.cn/thread-181019-3-1.html



%用最小的圆包围随机产生的五个点
%可以作为一个多目标规划问题来解决
x=[5.8434   9.1712  10.5420    12.0371  13.6629 ]';
y=[73.9697  84.4988 87.5433   90.3592  92.9460 ]';

x=rand(5,1);
y=rand(5,1);


%%
f=@(c) hypot(x-c(1),y-c(2));
%%
[c0,fval,r] = fminimax(f,mean([x,y]));
%%
clf
hold on
plot(x,y,'*')
plot(mean(x),mean(y),'oc')

plot(c0(1),c0(2),'+m')

theta=0:pi/20:2*pi;
plot(c0(1)+r*cos(theta),c0(2)+r*sin(theta),'r')
axis equal
figure(gcf)