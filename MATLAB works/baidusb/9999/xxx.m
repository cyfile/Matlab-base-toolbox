% bessel of first kind

%Bessel function of first kind
m=100;
x=linspace(0,30,m);

n=5;
a=0:n;

for b=a
JJ(b+1,:)=besselj(b,x);
end

figure;
hold on
set(gca,'colororder',spring(n+1));
plot(x,JJ','linewidth',1.5)