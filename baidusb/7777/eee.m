% Áú¸ñÏÖÏó
f=@(x) 1./(1+x.*x);
a=linspace(-5,5,200);
y=f(a);
plot(a,y,'k','linewidth',3)

hold on

for n=6:12;%%n=11
b=linspace(-5,5,n);
A=vander(b);
c=A\f(b)';
plot(a,polyval(c,a),'color',[(13-n)/8,(n-5)/8,1])

end