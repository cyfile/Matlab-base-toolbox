% 把一张十元的人民币换开，有几种办法？

% 正统递归：

%%%%%%%%%%%%%%%%%%%%%

function count=fun2(n,k)
% tic,fun2(1000,8),toc
%ans =
%   327631321
%Elapsed time is 158.549312 seconds.

MONEY=[2 5 10 20 50 100 200 500];
% if ~exist('k','var')
%
%     k=8;
% end
if n<2
    count=1;
    return
end

k2=find(MONEY<=n,1,'last');
%k2 是可分配的最大面额索引
%k 是轮到的建议分配面额的索引
k=min(k,k2);

if  k==1
    count=floor(n/2)+1;
    return
else
    count=0;
    for g=n:-MONEY(k):0
        count=fun2(g,k-1)+count;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

----------------------------------------

思路说明：

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%对于n分钱，仅用 一分 硬币来换，有
f1=@(n) arrayfun(@(x) 1,n);%种换法
%对于n分钱，仅用 二分 和 一分 硬币来换，有
f2=@(n) arrayfun(@(x) sum(f1(x:-2:0)),n);%种换法,即
f2=@(n) floor(n/2)+1;%种换法
%对于n分钱，仅用 五分 和 五分以下 硬币来换，有
f5=@(n) arrayfun(@(x) sum(f2(x:-5:0)),n);%种换法
%对于n分钱，仅用 一角 和 一角以下 钱币来换，有
f10=@(n) arrayfun(@(x) sum(f5(x:-10:0)),n);%种换法
%对于n分钱，仅用 两角 和 两角以下 钱币来换，有
f20=@(n) arrayfun(@(x) sum(f10(x:-20:0)),n);%种换法
%对于n分钱，仅用 五角 和 五角以下 钱币来换，有
f50=@(n) arrayfun(@(x) sum(f20(x:-50:0)),n);%种换法
%对于n分钱，仅用 一元 和 一元以下 钱币来换，有
f100=@(n) arrayfun(@(x) sum(f50(x:-100:0)),n);%种换法
%对于n分钱，仅用 两元 和 两元以下 钱币来换，有
f200=@(n) arrayfun(@(x) sum(f100(x:-200:0)),n);%种换法
%对于n分钱，仅用 五元 和 五元以下 钱币来换，有
f500=@(n) arrayfun(@(x) sum(f200(x:-500:0)),n);%种换法
%%
tic
f500(1000)
toc

%%

%ans =
%   327631321
%Elapsed time is 3.927516 seconds.

%%%%%%%%%%%%%%%%%%%%%%%%%%%

 

----------------------------------------

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
%%
%对于n分钱，仅用 一分 硬币来换，有
f1=@(n) arrayfun(@(x) 1,n);%种换法
%对于n分钱，仅用 二分 和 一分 硬币来换，有
f2=@(n) arrayfun(@(x) sum(f1(x:-2:0)),n);%种换法,即
f2=@(n) floor(n/2)+1;%种换法
%对于n分钱，仅用 五分 和 五分以下 硬币来换，有
f5=@(n) arrayfun(@(x) sum(f2(x:-5:0)),n);%种换法
%对于n分钱，仅用 一角 和 一角以下 钱币来换，有
f10=@(n) arrayfun(@(x) sum(f5(x:-10:0)),n);%种换法
%对于n分钱，仅用 两角 和 两角以下 钱币来换，有
f20=@(n) arrayfun(@(x) sum(f10(x:-20:0)),n);%种换法
%对于n分钱，仅用 五角 和 五角以下 钱币来换，有
f50=@(n) arrayfun(@(x) sum(f20(x:-50:0)),n);%种换法
%对于n分钱，仅用 一元 和 一元以下 钱币来换，有
f100=@(n) arrayfun(@(x) sum(f50(x:-100:0)),n);%种换法
%对于n分钱，仅用 两元 和 两元以下 钱币来换，有
f200=@(n) arrayfun(@(x) sum(f100(x:-200:0)),n);%种换法
%对于n分钱，仅用 五元 和 五元以下 钱币来换，有
f500=@(n) arrayfun(@(x) sum(f200(x:-500:0)),n);%种换法
%%
toc
f500(1000)
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
tic
syms n k5 k10 k20 k50 k100 k200 k500
F1(n)=sym(1);
F2(n)=symsum(F1(1),[0,fix(n/2)]);
F5(n)=symsum(F2(n-k5*5),k5,[0 fix(n/5)]);
F10(n)=symsum(F5(n-k10*10),k10,[0 fix(n/10)]);
F20(n)=symsum(F10(n-k20*20),k20,[0 fix(n/20)]);
F50(n)=symsum(F20(n-k50*50),k50,[0 fix(n/50)]);
F100(n)=symsum(F50(n-k100*100),k100,[0 fix(n/100)]);
F200(n)=symsum(F100(n-k200*200),k200,[0 fix(n/200)]);
F500(n)=symsum(F200(n-k500*500),k500,[0 fix(n/500)]);
%%
toc
F500(1000)
toc

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%

Elapsed time is 0.010366 seconds.
ans =
   327631321
Elapsed time is 3.883614 seconds.
Elapsed time is 15.892982 seconds.
ans =
327631321
Elapsed time is 125.073869 seconds.

%%%%%%%%%%%%%%%%%%%%%%%%%%%

----------------------------------------

改进后的递归

%%%%%%%%%%%%%%%%%%%%%%%%%%%

function count=fun2(n,k)
%快一点，但不好理解的程序
%tic,fun2(1000,8),toc
%ans =
%   327631321
%Elapsed time is 90.619933 seconds.
MONEY=[2 5 10 20 50 100 200 500];
% if ~exist('k','var')
%     k=8;
% end

if n<2
    count=1;
    return
end

if   n<5 || k==1
    count=floor(n/2)+1;
    return
else
   
    k2=find(MONEY<=n,1,'last');
    %k2 是可分配的最大面额索引
    %k 是轮到的建议分配面额的索引
    k=min(k,k2);
    count=0;
    for g=n:-MONEY(k):0
        count=fun2(g,k-1)+count;
    end
end