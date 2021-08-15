%% center
a = 192;
D = zeros(2*a+1);
%%
r0 = [22 32 35 40]*64;
p0 = [45 55 15 35 ];

l = [7 6 5 5]*64;
z = [ 250 160 340 70]+5;
r = [4 3 3 3]*64;

for k=0:3
    for n = 1:4
        zeta = k*90+p0(n) ;
        col = a+1 + round( r0(n) *cosd(zeta) /64);
        row = a+1 - round( r0(n) *sind(zeta) /64);
        [ro,co]=tree_FCN_arc( l(n), k*90+z(n) ,r(n));
        D(sub2ind(size(D),row + ro ,col + co))=1;
    end
end

% imshowpair(old,D)
%figure,
imshow(D)
sum(D(:))
%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
treeK = D ;








