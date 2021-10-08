% BezierÇúÏß
clf
N=randi([2,6]);
P=rand(N,2);
plot(P(:,1),P(:,2),'k-o')
hold on
%%
u=linspace(0,1,50)';
v=1-u;
c=bsxfun(@power,u,0:N-1).*bsxfun(@power,v,N-1:-1:0);
%%
%c=gallery('binomial',N);c(1,:)
%c=diag(fliplr(pascal(N)));

%poly(-ones(4,1))

%a(1)^3*poly(repmat(roots(a),3,1))

%u^3*poly(repmat(roots([u,1-u]),3,1))

%%
C=bsxfun(@times,c,diag(fliplr(pascal(N)))');
NP=C*P;
plot(NP(:,1),NP(:,2),'-')
%%
k=rand;
%r=[k,1-k];full(spdiags(r(ones(1,N-1),:), [0 1], N-1,N));
C=toeplitz([k,zeros(1,N-2)],[k 1-k zeros(1,N-2)]);
nP=P;
clr=lines(N);
for g=N-1:-1:1
    nP=C(1:g,1:g+1)*nP;
    plot(nP(:,1),nP(:,2),'+-','color',clr(g,:))
end

 