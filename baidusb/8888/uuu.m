% eigenvalueandvector2

clear
xy=1.5;
axis([-xy,xy,-xy,xy]);
axis equal
hold on
cla
% % t = 0:0.05:2*pi+1;
% % x=cos(t);
% % y=sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=200;
[X,Y,Z] = cylinder(1,n);
x=X(1,:);
y=Y(1,:);
plot(x,y,'k')

a=sqrt(2);
dm=diag([a,1/a]);
B=dm*[x;y];
% plot(B(1,:),B(2,:))


p=orth(rand(2));
T=p*dm;
A=p*B;
plot(A(1,:),A(2,:))

text(1,1,['|A|=',num2str(det(T)),'=Ãæ»ý'])

[V,D] = eig(T);
% V=mV*diag(1./sqrt(sum(mV.*mV)));
nV=V*D;
quiver([0,0],[0,0],V(1,:),V(2,:),0)
quiver([0,0],[0,0],nV(1,:),nV(2,:),0)
%%

 

px=0;
py=0;
pnx=0;
pny=0;
ho=plot(px,py,'-ko','MarkerSize',10,'YDataSource','[0;py]','xdatasource','[0;px]');
hn=plot(pnx,pny,'-bs','MarkerSize',10,'YDataSource','[0;pny]','xdatasource','[0;pnx]');

for m=1:n
    px=x(m);
    py=y(m);
    pnx=A(1,m);
    pny=A(2,m);
    refreshdata(ho,'caller')
    refreshdata(hn,'caller')
    pause(0.04)
end
%%%%%%%%%%%%%%%%%
figure
eigshow(T)
%%
% % a=diag(rand(1,2))
% % p=orth(rand(2))
% % p*a*p'
