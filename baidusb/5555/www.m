% ≥…º®≈≈–Ú
a=[4 1 3 1 2];
%%%%%%%%%%%%%%%%%%%%
[b,~,m] = unique(a);
[n,~]=hist(a,b);
k=cumsum([1 n(1:end-1)]);
k(m)

%%%%%%%%%%%%%%%%%%%
[~,ind1]=sort(a);
[~,ind2]=sort(ind1)