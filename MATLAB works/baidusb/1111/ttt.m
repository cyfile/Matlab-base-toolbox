% detrend
a=rand(3,4);
bsxfun(@minus,a,mean(a))
detrend(a,'c')
%%
detrend(a)

sum(a)

detrend(a,'c')-detrend(a)

diff(a-detrend(a))

%%
tmp=[1:size(a,1);ones(1,3)]';
tmp=[1:size(a,1);2*ones(1,3)]'-1;
a-tmp*(tmp\a)
%%
x=[1:size(a,1)]';
r=zeros(size(a));
for k=1:size(a,2)
    p = polyfit(x,a(:,k),1);
    r(:,k)=a(:,k)-polyval(p,x);
end
r