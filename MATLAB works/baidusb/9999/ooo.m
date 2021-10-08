% solvediff

clear
%c=.01;
x0=-3.1:.2:3;
y0=-3:.3:3.1;

[x,y]=meshgrid(x0,y0);

u=ones(size(x));
v=1-y.^2;
u=u./sqrt(u.^2+v.^2);
v=v./sqrt(u.^2+v.^2);
%d=sqrt(1+(1-y.^2).^2);
% u=c./d;
% v=c*(1-y.^2)./d;
% u=ones(size(x));
% v=1-y.^2;

%%

quiver(x,y,u,v,1)
%%
hold on
) [1;1-y(2)^2];


[X,Y]=ode45(myode1,[-3,3],[-3,-.99]);

plot(X,Y(:,2),'-r')


myode2 ) [1-y^2];
[X,Y]=ode45(myode2,[-3,3],[-.99]);
plot(X,Y,'og')
%----------------------------------------------
% function dy=myode1(t,y)
%
% dy=[1;1-y(1)^2];
% end
% % % dy = zeros(3,1);    % a column vector
% % % dy(1) = y(2) * y(3);
% % % dy(2) = -y(1) * y(3);
% % % dy(3) = -0.51 * y(1) * y(2);