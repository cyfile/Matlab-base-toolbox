% approximation to arctan(x) using symbolic math toolbox

%approximation to arctan(x) using symbolic math toolbox
clear
subplot(211)
hold on

n=5;

colmap=flipud(spring(n+2));
colmap=colmap(2:end-1,:);

syms x
for k=1:n
f=taylor(atan(x),2*k);
h=ezplot(f);
set(h,'color',colmap(k,:));
X(:,k)=get(h,'xdata');
Y(:,k)=get(h,'ydata');
end
h=ezplot(atan(x));
XX=get(h,'xdata');
YY=get(h,'ydata');
set(h,'linewidth',1.5)

 

set(gcf,'DefaultAxesColorOrder',colmap)
subplot(223)
%
%set(gca,'colororder',colmap)
semilogy(X,abs(Y))
hold on
h=semilogy(XX,abs(YY));
set(h,'linewidth',1.5,'color','b')
axis([-2,2,.1E-1, .1E3])

 


subplot(224)
%set(gca,'colororder',colmap)
semilogy(X,abs(Y-repmat(YY',[1,n])))
axis([-2,2,1E-6, 1E2])