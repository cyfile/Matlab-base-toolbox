% 幻方的三种形态
for k=15:25
    X=magic(k);
    X(end+1,end+1)=5;
    h=pcolor(X);
    pause(1)
end
trace(X)
sum(X)
sum(X,2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colormap(cool)
for k=15:24
    X=magic(k);
    X(end+1,end+1)=5;
    h=pcolor(X);
    pause(1)
end
trace(X)
sum(X)
sum(X,2)

 

%%%%%%%%%%%%%%%%%%%%%%%%5555

for k=2:20
    contour(magic(k))
    pause(0.5)
end