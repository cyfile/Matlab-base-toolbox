% 太阳高度角和方位角

clc
clear
syms  s p t
%
x=cos(s)*cos(t);
y=sin(t)*sin(p)*cos(s)-cos(p)*sin(s);
z=sin(t)*cos(p)*cos(s)+sin(p)*sin(s);

% % % % a=(i/(2*exp(i*t)) - (i*exp(i*t))/2);%sin(t)
% % % % b=exp(i*t)/2 + 1/(2*exp(i*t));%cos(t)
% % % % d=[subs(a,t,[s;t;p]);subs(b,t,[s;t;p])];
% % % % c=simplify(d);
% % % %
% % % % i=subs([x,y,z],c,d);
% % % % x=i(1);
% % % % y=i(2);
% % % % z=i(3);

% % simplify((x^2+y^2+z^2)^.5);
% % simplify(x^2/(y^2+x^2))
% % solve('sin(h)-z',h);
% % finverse


% T=12.001:.5:24;
% t=(T-18)/6*pi/2;
% t=t';

% [sp,ss]=meshgrid(linspace(0,pi/2,9),...
%     linspace(-deg2rad(23),deg2rad(23),10));
[t,s]=meshgrid(linspace(-pi/2,pi/2,12*3+1),linspace(-deg2rad(23),deg2rad(23),9));
% s=deg2rad(20);
% s=ss;
p=deg2rad(33); %mapping toolbox function

hh=subs(rad2deg(asin(z)));
%dd=subs(rad2deg(atan(y/x)));
dd=subs(rad2deg(acos(x/(y^2+x^2)^.5)));

figure
h=[hh,fliplr(hh)];
d=[dd-90,-fliplr(dd)+89];

ti=linspace(1,37,5);

plot(d(:,ti),h(:,ti))
hold on

jetcolor=jet;
set(gca,'ColorOrder',jetcolor(round(linspace(15,50,9)),:))

plot(d',h')

plot([-90,90],[0,0],'k','LineWidth',3)


%
%
% h=[hh';flipud(hh')];
% d=[dd'-90;-flipud(dd')+90];


% hold on
% plot(d,h)
% ezplot(d,h,[0:3])
% ezplot(d,h,[0,100])