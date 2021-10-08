% logistic

clear
%
x(1,:)=.1:.1:.9;

 

figure(1)

set(gcf,'DefaultAxesColorOrder',winter(9));
y=kron([1:141]',ones(1,9));
z=kron(1:9,ones(141,1));
h1=plot3(y,z,y,'zDataSource','x');
xlabel('n')
ylabel('x0')
zlabel('xn')
% set(gca,'colororder',winter(9))

hold on

for lamda=0:.1:4;
% kron(lamda,ones
for i=1:140
    x(i+1,:)=lamda.*x(i,:).*(1-x(i,:));
end
    refreshdata(h1,'caller') % Evaluate y in the function workspace
 drawnow;
    pause(.2);
end
view(0,83)

figure(2)
set(gca,'colororder',winter(9))
hold on
%xx=x(:,1);
xf2=kron(x,[1;1]);
yf2=xf2(2:end,:);

yf2(1,:)=0;
xf2(end,:)=[];

h2=plot(xf2,yf2,'xDataSource','xf2','yDataSource','yf2');

 

xx=0:.05:1;
yy=lamda*xx.*(1-xx);
plot(xx,yy)
plot(xx,xx)