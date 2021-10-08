% van der Pol limit cycle

clear
a=.6;
myode= @(t,x) [x(2)-a*(x(1)^3-x(1));-x(1)];

[q,p]=meshgrid(-2:1:2);
subplot(5,2,1:8)
plot(p,q,'ro')

axis([-3,3,-3,3])


qp=[q(:),p(:)]';


hold on
for x0=qp
[t,x]=ode45(myode,[0,50],x0);
plot(x(:,1),x(:,2))
pause(.1)
end
h8=subplot(529)
h9=plot(t,x(:,2),'xdatasource','td','ydatasource','yd');
% % %%
% %
% % xlabel('sdss','Position',[70   -3    10])
% % %%

% [t,x]=ode45(myode,[0,100],[5,5]);
% plot(x(:,1),x(:,2))
subplot(5,2,10)
plot(0,0.1,'ro')
hold on
h0=plot(x(:,1),x(:,2),'xdatasource','xd','ydatasource','yd');
% td=t;
% xd=x(:,1);
hold off
for i=logspace(log10(0.1),log10(5),10)
myode= @(t,x) [x(2)-i*(x(1)^3-x(1));-x(1)];
[t,x]=ode45(myode,[0,100],[0,0.1]);
% isequal(x(:,1),xd)
xd=x(:,1);
yd=x(:,2);
refreshdata(h0,'caller')
% isequal(td,t)
td=t;
refreshdata(h9,'caller')
set(get(h8,'XLabel'),'String',['\lambda = ',num2str(i)],'Position',[70   -3    10]);
pause(0.7)
end