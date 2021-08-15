%% neutral
a = 192;
A = zeros(2*a+1);
%%
% 52*2=104     [ 34 68 102 ]*64 
% [0 14 28 42 56 60 74 86 100 ]
% [    (28)      (67+1)       ]
% [3.5 8.5]*8 = [28 68 ] +- [8 12]
% [ 20 36 ] [56 80]
%% 
r0 = [ 80 60 67 77]*64;
p0 = [ 10 10 3 4];

l = [ 5 8 5 8]*64;
z = [ 20 160 220 280];
r = [ 3 4 3 4]*64;

%
for k=(0:11)*30
    for n = 1:4
        zeta = k+p0(n) ;
        col = a+1 + round( r0(n) *cosd(zeta) /64);
        row = a+1 - round( r0(n) *sind(zeta) /64);
        [ro,co]=tree_FCN_arc( l(n), k+z(n) ,r(n));
        A(sub2ind(size(A),row + ro ,col + co))=1;
    end
end
%%
%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
%%
% [ 20 36 ]
r0 = [36 30 22 34 ]*64;
p0 = [35 55 45 10 ];

l = [5 6 7 5 ]*64;
z = [70 160 250 340 ]+5;
r = [3 3 4 3 ]*64;

for k=0:3
    for n = 1:4
        zeta = k*90+p0(n) ;
        col = a+1 + round( r0(n) *cosd(zeta) /64);
        row = a+1 - round( r0(n) *sind(zeta) /64);
        [ro,co]=tree_FCN_arc( l(n), k*90+z(n) ,r(n));
        A(sub2ind(size(A),row + ro ,col + co))=1;
    end
end


%% ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
% figure;
imshow(A)
sum( A(:) )
% imshowpair(old,D)
%
treeN =  A;

