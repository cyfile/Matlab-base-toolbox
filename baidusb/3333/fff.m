% image histogram adjustment
function aaa
%
n=127;
A=bsxfun(@plus,0:n,(0:n)')/n/2;
bbb(1,A)

B=imadjust(A);
bbb(3,B)
%%
C=imadjust(A,[0.5 1]);
bbb(5,C)
%%
D=imadjust(A,[],[],0.5);
bbb(7,D)
%%
F = histeq(A, n);
bbb(9,F)
%%
G = adapthisteq(A...
    ,'NumTiles',[2 2]...
    ,'Distribution','exponential'...
    ,'Alpha',1);
bbb(11,G)

function bbb(k,Z)
subplot(3,4,k)
imshow(Z)
subplot(3,4,k+1)
imhist(Z)