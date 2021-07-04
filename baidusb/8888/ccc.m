% histandrand
subplot(323)
hist(randi(1,2,100))
axis([0,2,0,1])
%%

subplot(321)
hist(rand(50,25))
%%

subplot(322)
hist(randn(50,25))

%%
subplot(324)

barh([1,2],randi(1,2,100),'histc')
set(gca,'yLim',[1 1.8])
%%
subplot(313)

[x,y,z] = ellipsoid(0,0,0,10,5,5,50);

n=25;
m=10;
k=15;

x=x(m:k,n+1:end);
y=y(m:k,n+1:end);
z=z(m:k,n+1:end);
contourf(x,y,z,20)
%%

a=findobj(gca,'type','patch');
b=get(a,'facecolor');
set(a,'edgeColor','none')