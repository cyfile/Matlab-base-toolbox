% eigenvalueandvector

clear
xy=1.2;
axis([-xy,xy,-xy,xy]);
axis equal
hold on
cla
t = 0:0.05:2*pi+1;
x=cos(t);
y=sin(t);

 

tm=rand(2);
% tm=1/2*[1,0;3,1];
text(1,1,['|A|=',num2str(det(tm)),'=Ãæ»ý?'])

[V,D] = eig(tm);
% V=mV*diag(1./sqrt(sum(mV.*mV)));
nV=V*D;
quiver([0,0],[0,0],V(1,:),V(2,:),0)
quiver([0,0],[0,0],nV(1,:),nV(2,:),0)


mv=tm*[x;y];


nx=mv(1,:);
ny=mv(2,:);

plot(x,y)
plot(nx,ny)

px=0;
py=0;
pnx=0;
pny=0;
ho=plot(px,py,'ro','MarkerSize',10,'YDataSource','py','xdatasource','px');
hn=plot(pnx,pny,'ms','MarkerSize',10,'YDataSource','pny','xdatasource','pnx');

for n=1:length(t)
    px=x(n);
    py=y(n);
    pnx=nx(n);
    pny=ny(n);
    refreshdata(ho,'caller')
    refreshdata(hn,'caller')
    pause(0.24)
end