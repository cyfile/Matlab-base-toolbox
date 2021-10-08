% voronoi uisetcolor patch
x = gallery('uniformdata',[1 10],0);
y = gallery('uniformdata',[1 10],1);
[vx,vy]=voronoi(x,y);
scatter(x,y,10,'r','filled')
hold on
n=length(vx);
c = uisetcolor;
h=patch([vx;flipud(vx)],[vy;flipud(vy)],[-ones(2,n);ones(2,n)],c);
view(45,45)