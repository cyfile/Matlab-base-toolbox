% 用convhull 求公切线
figure
hold on
x=rand(2,20)';
y=rand(2,20)';
al=[x;y];
plot(x(:,1),x(:,2),'+')
plot(y(:,1),y(:,2),'ro')

k=convhull(al);
ind=diff(k<=20)~=0;
fvex=al(k([ind;false]),:);
tvex=al(k([false;ind]),:);

plot([fvex(:,1)';tvex(:,1)'],[fvex(:,2)';tvex(:,2)'],'g')