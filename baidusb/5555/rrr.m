% 判断线段是否与多边形有交点1
function aaa
%% plot
close all
hold on
l=rand(2);%直线上的两点
plot(l(:,1),l(:,2),'-*r')
%%%%%%%%%%%%%%%%%%
s=rand(4,2);
TRI = delaunay(s);
tmp=[intersect(TRI(1,:),TRI(2,:));setxor(TRI(1,:),TRI(2,:))];
% K = convhull(xs,ys);
s=s(tmp(:),:);  %多边形顶点
plot(s([1:end,1],1),s([1:end,1],2))


if lineandpolygon(l,s)
    disp('直线有交点1')
end
   
%%
ss=s([1:end,1],:);
for n=1:length(s)
    if twosegment2(l,ss(n:n+1,:))
        disp('线段有交点2')
        break
    end
end
%%
%%%%%%%%%%%%%%%%%%%%%%
function isthrough=lineandpolygon(l,s) %判断两点确定的直线是否通过多边形
zp=l(1,:);
lv=l(2,:)-zp;
nv=[lv(2),-lv(1)];
sv=bsxfun(@minus,s,zp);
d=sv*nv'>0;
isthrough=xor(any(d),all(d));

%%
function isintersect=twosegment(l,s)%判断两个线段是否相交
s1=s(1,:);
s2=s(2,:);
l1=l(1,:);
l2=l(2,:);
ds=s2-s1;
dl=l2-l1;
dsl=s1-l1;
C=dsl/[dl;-ds];
isintersect=all(C<1)&&all(C>0);
%%
function isintersect = twosegment2(l,s)%判断两个线段是否相交
twoc=(l-s)';
a=[1,-1];
b=[0 1;-1 0];
f1=prod(a*l*b*twoc)<0;
f2=prod(a*s*b*twoc)<0;
isintersect=all([f1,f2]);