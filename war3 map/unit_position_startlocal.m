% 给定半径区间和角度间隔 找出半径差最小的几(三)个离散点
%%
% 192/2*128==12288;
a=7936;
r1= hypot(a-256,a-256);
r2= hypot(a+256,a+256);
b=pi/20;
%%
P{1}=aaa(r1,r2,b);
P{2}=aaa(r1,r2,3*b);
P{3}=aaa(r1,r2,5*b);
% return
%%
plot(P{1}(3,:),P{1}(3,:),'o')
hold on
plot(P{2}(3,:),P{2}(3,:),'x')
plot(P{3}(3,:),P{3}(3,:),'p')
r = sqrt(P{1}(3,6))
%%
S = sort([P{1}(3,:),P{2}(3,:),P{3}(3,:)]);
n = size(S,2);
R = [S;S;S;S;S];
r=zeros(1,3);
for m = 1:n
    for k =1:3
        a=find(P{k}(3,:)>=S(m),1,'first');
        if isempty(a)
            r(k)=inf;
            break
        end
        R(k,m)=a;
        r(k)=P{k}(3,a);
    end
    R(4,m)=max(r)-S(m);
end
%
% plot(R(4,:))
[b,ind]=sort(R(4,:));
a=1;
%%
index = ind(a);
[b(a),R(4,index),r]
a=[P{1}(:,R(1,index)),P{2}(:,R(2,index)),P{3}(:,R(3,index))]

x = a(1,:); y= a(2,:);
startLocation = [x y([2 1]);y x([2 1])]

%%
function P = aaa(r1,r2,z)
x=r1*cos(z); y=r2*cos(z);
x64 = x-rem(x,64):64:y-rem(y,64);
y = x64 * tan(z);
k = rem(y,64);
ind = find(k<34); ind2= find(k>30);
xy = [x64(ind),x64(ind2);y(ind)-rem(y(ind),64),y(ind2)-rem(y(ind2),64)+64];
[s,k]=sort(sum(xy.*xy));
P = [xy(:,k);s];
end