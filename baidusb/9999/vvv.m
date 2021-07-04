% multiply matrix

%approximate sin(x) by Matrix multiplication
clear
m2=200;
x=linspace(-20,20,m2);
A=fliplr(vander(x));
A=A(:,2:2:end);
m1=floor(m2/2);


nn=m1;
n=1:nn;
cof=(-1).^(n-1)./factorial(2*n-1);
c=repmat(cof',[1,m1]);
C=c.*triu(ones(nn));

figure
% colmap=jet(20);
% colmap=fliplr(colmap(1:10,:));
axis ([-20,20,-20,20])
set(gca,'colororder',jet(25))

hold on
plot(x,A*C)
plot(x,sin(x),'r','linewidth',1.5)