192/2*128==12288;
r1= hypot(7936, 7936);% (8448 8448)
r2= hypot(11904 ,1024)+10;%12288-512+128

P{1}=aaa(r1,r2,pi/20);
P{2}=aaa(r1,r2,3*pi/20);
P{3}=aaa(r1,r2,5*pi/20);
S = sort([P{1}(3,:),P{2}(3,:),P{3}(3,:)]);
n = size(S,2);
R = [S;S;S;S;S];
tmp=zeros(1,3);
for m = 1:n
    for k =1:3
        a=find(P{k}(3,:)>=S(m),1,'first');
        if isempty(a)
            tmp(k)=inf;
            break
        end
        R(k,m)=a;
        tmp(k)=P{k}(3,a);
    end
    R(4,m)=max(tmp)-S(m);
end
[aa,ind]=sort(R(4,:));
index = ind(1);
aa(1),R(4,index)
a=[P{1}(:,R(1,index)),P{2}(:,R(2,index)),P{3}(:,R(3,index))]

x = a(1,:); y= a(2,:);
sx=[x y([2 1])];sy =[y x([2 1])];

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