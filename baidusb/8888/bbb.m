% hessianmatrix
[x,y] = meshgrid(-2:.2:2, -2:.2:2);
figure
%%
d=0;
b=2;
c=0;
a=[d,b;b,c];
z=a(1,1)*x.*x+a(2,2)*y.*y+a(1,2)*x.*y+a(2,1)*y.*x;

surfc(x,y,z)