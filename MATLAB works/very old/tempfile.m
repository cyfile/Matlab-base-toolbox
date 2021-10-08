a=rand(5);
a=a+a'
[v,d]=eig(a);
d=diag(10*rand(1,5))
a=v*d*v'
%%
V=v
V=V*diag(1./diag(d).^0.5)
V*d*V'
%%
k=4
a=[0 1 0 ;-k -1 -k;0 -1 -4]
det(a),det(a(1:2,1:2)),det(a(2:3,2:3))
eig(a)