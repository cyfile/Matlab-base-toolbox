% 用德劳内三角或点集的凸包用4个随机的点构成一个四边形
%%%%%%%%%%%%%%%%%%
v=rand(4,2);
K = convhull(v);
if length(K)<=length(v)
    v=[v;v(1,:)];
else
    v=v(K,:);
end
plot(v(:,1),v(:,2))
%%%%%%%%%%%%%%

xs=rand(4,1);
ys=rand(4,1);
TRI = delaunay(xs,ys);
tmp=[intersect(TRI(1,:),TRI(2,:));setxor(TRI(1,:),TRI(2,:))];
% K = convhull(xs,ys);
xs=xs(tmp(:));
ys=ys(tmp(:));
plot(xs([1:end,1]),ys([1:end,1]))