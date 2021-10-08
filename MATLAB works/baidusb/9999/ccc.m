% plotgraph

subplot(321)
sn=@(x) sin(1./x);
fplot(sn,[.01 .1])
subplot(322)
fplot(@(x)sin(1./x))  %fplot('sin(1./x)',[.01 .1])
gtext('添加图例')
pause(1);
subplot(323)
[x,y,z]=sphere(30);
colormap(jet);
surf(x,y,z);
shading flat;
pause(1);
shading interp;
pause(1);
shading faceted;


subplot(324)
n=8;
r=(0:n)'/n;
theta=pi*(-n:n)/n;
x=r*cos(theta);
y=r*sin(theta);
c=r*cos(2*theta);
pcolor(x,y,c)

subplot(313)
%%

pcolor([6,2,3,4;1,1,1,6;4,3,2,1;1,1,1,-1])%最大值，最小值对在colormap中的索引会产生影响
                                          %最后一列，一行不用
%%