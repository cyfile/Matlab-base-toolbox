% Soliton

clear
%%%%%%%%%%%%%%%%%%
subplot(221)
a=4;
c0=0;
[t,x]=meshgrid(-10:.1:10);
u=sech(sqrt(a)*(x-a*t-c0).^2/2);

mesh(t,x,u)
colormap summer

axis fill
%%%%%%%%%%%%%%%%
subplot(212)
hold on
set(gca,'colororder',autumn)
[t2,x2]=meshgrid(-10:.4:10,-50:.8:50);
z=12*(3+4*cosh(8*t2-2*x2)+cosh(64*t2-4*x2))...
    ./(cosh(36*t2-3*x2)+3*cosh(28*t2-x2)).^2;

plot3(t2,x2,z)
view(40,40)
axis([-10 10 -50 50 0 10])


%%%%%%%%%%%%%%%%%%%
subplot(222)
% hold on
% axis
hold on
set(gca,'colororder',winter)

plot3(t,x,u)
axis([-2 2 -3 3 0 2])
xlabel('time');ylabel('x');zlabel('u');

n=0;
h = msgbox('stop rotating','stop','warn');
while  ishandle(h)
n=n+3;
view(n,20)
pause(0.04);
if n>360
    n=mod(n,360);
end
end