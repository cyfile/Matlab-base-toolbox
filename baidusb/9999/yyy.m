% natural exponent

%using ploynomial function approximate natural exponent
n=9;
cof=1./factorial(0:n-1);
C1=kron(cof,ones(n,1));
C1=fliplr(C1.*tril(ones(n)));

m=100;
x=linspace(-5,5,m);

y=exp(x);


figure
semilogy(x,y,'r','linewidth',2)
hold on
autumncol=autumn(n+5);
k=n;

for C=C1'
semilogy(x,polyval(C,x),'color',autumncol(k,:))

 



k=k-1;
end