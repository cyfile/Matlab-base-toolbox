%% center
a = 192;
[x,y]=meshgrid( (-a:a)*64 );
v = x+1i*flipud(y);
r = abs(v);

D = zeros(2*a+1);
D( 27*128<r & r<43*128 ) = 1;
D( 7*128<r & r<21*128 ) = 1;

D(2:2:end,:)=0;
D(1:4:end,2:2:end)=0;
D(3:4:end,1:2:end)=0;
%%
% d = [27 31 35 39 43]*128;
d = [43 39 35 31 27 ]*128;
z0 = 0:360/8:359;
z= [0 1 2 3 4 ]*4;
z= [0 0 0 0 0];
for k = 1:5
    xx = d(k)*cosd(z0+z(k));
    yy = d(k)*sind(z0+z(k));
    M=tree_FCN_hole(xx,yy,3*128);
    D(logical(M))=0;
end

%%
% d = [7 10.5 14 17.5 21]*128;
d = [ 21 17.5 14 10.5 7]*128;
z0 = 0:360/4:359;
z= [-1 0 1 2 3]*-3;
z= [20 20 20 20 20];
for k = 1:5
    xx = d(k)*cosd(z0+z(k));
    yy = d(k)*sind(z0+z(k));
    M=tree_FCN_hole(xx,yy,3*128);
    D(logical(M))=0;
end

% imshowpair(old,D)
%figure,
imshow(D)
sum(D(:))
%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
treeK = D ;








