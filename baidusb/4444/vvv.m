% 2-D滤波器和矩阵的45度旋转
X=hadamard(20);
%h=pcolor(X);
%%
fl=fspecial('gaussian',10);
Z=filter2(fl,X);
map = interp2(Z,3);
[a,b]=size(map);
lef=[zeros(1,a-1);spdiags(map(2:end,:),2-a:0)];
nmap=[lef,spdiags(map,0:b-1)];
nmap(-0.2<nmap&nmap<0.2)=nan;
h=pcolor(nmap)
set(h,'edgealpha',0)
axis equal
axis ij

colorbar