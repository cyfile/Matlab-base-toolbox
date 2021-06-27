A=imread('dij','jpg');
B=rgb2gray(A);
% imshow(B)
%%
C = edge(B);
%%

D = ~bwareafilt(~C, 7);
% imshow(D)
% D3 = ~bwareaopen(~C,20);
% imshowpair(C,D,'diff')
imshowpair(C,D,'')


SE = strel('diamond',1);
 D= imdilate(C,SE);
%A= imerode(D,SE);
imshow(D)

A = imresize(D,0.4);
imshow(A)
%%
[r,c] = find(A==0);
fileID = fopen('war3map.doo','r+');
fseek(fileID, 32, -1);
fwrite(fileID,16*[c';-r'],'2*float',42,'l')
fclose(fileID);
%%
A = checkerboard(3,2,3);
imshow(A)
A = [A;A];
SEs = strel('square',3);
SEs.Neighborhood
% D= imdilate(J,SEs);
%A= imerode(D,SE);
SEd = strel('diamond',1);
SEd.Neighborhood
%%
B = [ imdilate(A,SEs);imdilate(A,SEd)];
C = [ imerode(A,SEs);imerode(A,SEd)];
D = [ imopen(A,SEs);imopen(A,SEd)];
E = [ imclose(A,SEs);imclose(A,SEd)];
 imshowpair( A, C ,'falsecolor')
%%
n=15;
a=zeros(n);
a(3,3:n-2)=1;a(4,4:n-2)=1;a(5,5:n-2)=1;
a(3:n-3,n-2)=1;a(3:n-4,n-3)=1;a(3:n-5,n-4)=1;
A= a+0.5*rot90(a,2);