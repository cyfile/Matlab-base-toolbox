% natural logarithm approximation

% Power series approximation to natural logarithm  by fundamental matlab functions
m=7;
n=1:m;
cof=(-1).^(n-1)./n;


mm=100;
x=linspace(-2,2,mm);


A=kron(n,ones(mm,1));
B=kron(x',ones(1,m));
C=kron(cof,ones(mm,1));

D=cumsum(B.^A.*C,2);

y=log(1+x);

figure
set(gcf,'DefaultAxesColorOrder',cool(m));

subplot(211)
hold on
%set(gca,'ColorOrder',cool(m))
plot(x,D)
plot(x,y,'r','LineWidth',2)

subplot(223)

%set(gca,'ColorOrder',cool(m))
semilogy(x,abs(D))
hold on
semilogy(x,abs(y),'r','LineWidth',2)

subplot(224)
hold on
%set(gca,'ColorOrder',cool(m))
semilogy(x,abs(D))
semilogy(x,abs(y),'r','LineWidth',2)
axis([-1 1 0 1.5])