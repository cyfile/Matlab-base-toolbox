function [P,r]=tree_FCN_optim( A )
a=192;
n = 2*a+1;
%
B = ones(n+1);
B(2:2:end,:)=0;
B(1:4:end,2:2:end)=0;
B(3:4:end,1:2:end)=0;

M={B(1:n,1:n),B(1:n,1:n)',B(1:n,2:n+1),B(1:n,2:n+1)',...
    B(2:n+1,1:n),B(2:n+1,1:n)',B(2:n+1,2:n+1),B(2:n+1,2:n+1)'};

r = zeros(1,8);
for n = 1:8
    C = M{n} & A;
    r(n) = sum(C(:));
end
[~,ind]=max(r);

P = M{ind} & A;

