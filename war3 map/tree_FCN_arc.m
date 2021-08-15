function [Ro,Co]=tree_FCN_arc(L, Z, R)
a=192;
r0=a+1;
c0=a+1;
A = zeros(2*a+1);
%% 
z1 = Z+70;
z2 = Z+20;
[r1,c1,rend,cend]=tree_FCN_line(R, z1 );
[r2,c2]=tree_FCN_line(L, z2 );
A(sub2ind(size(A),r0 + r1 ,c0 + c1))=1;
A(sub2ind(size(A),r0 + r2 + rend,c0 + c2 + cend ))=1;
%% 
z1 = Z-70;
z2 = Z-20;
[r1,c1,rend,cend]=tree_FCN_line(R, z1 );
[r2,c2]=tree_FCN_line(L, z2 );
A(sub2ind(size(A),r0 + r1 ,c0 + c1))=1;
A(sub2ind(size(A),r0 + r2 + rend,c0 + c2 + cend))=1;

%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
% imshow(A)
[row,col] = find(A);
Ro = row-r0;
Co = col-c0;

