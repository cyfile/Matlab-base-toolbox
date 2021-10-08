A=imread('ted','jpg');
B=rgb2gray(A);
% imshow(B)
%%
C = edge(B);
%sobelGradient = imgradient(B);
% normal_edges = edge(B,'canny',0.22);
% imshow(normal_edges,[])
D = ~bwareaopen(~C,20);
% imshow(D)
% imshowpair(C,D,'diff')
imshowpair(C,D)
%%

SE = strel('diamond',1);
D= imdilate(C,SE);
%A= imerode(D,SE);
imshow(D)

A = imresize(D,0.4);
imshow(A)
%%
return
%%
A = checkerboard(3,2,3);
imshow(A)
A = [A;A];
SEs = strel('square',3);
SEs.Neighborhood

SEd = strel('diamond',1);
SEd.Neighborhood
%%
B = [ imdilate(A,SEs);imdilate(A,SEd)];
C = [ imerode(A,SEs);imerode(A,SEd)];
D = [ imopen(A,SEs);imopen(A,SEd)];
E = [ imclose(A,SEs);imclose(A,SEd)];
imshowpair( A, C ,'falsecolor')
