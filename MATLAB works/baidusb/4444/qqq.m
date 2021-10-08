% connected components图像的联通区域regionprops bwconncomp labelmatrix label2rgb
img=imread('000.bmp');
img=imread('022.bmp');
subplot(281);imshow(img)
level=graythresh(img);
B=im2bw(img,level);
subplot(282);imshow(B)
B=~B;
subplot(283);imshow(B)
%%%
STATS = regionprops(B,'BoundingBox');
subplot(284);imshow(B)
for m=1:length(STATS)
rectangle('Position', STATS(m).BoundingBox, ...
        'EdgeColor','r');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C=B;
for m=1:length(STATS)
   k= STATS(m).BoundingBox;
C(k(2)+.5:k(2)-.5+k(4),k(1)+.5:k(1)-.5+k(3))=1;
end
subplot(285);imshow(C)

STATS = regionprops(C,'BoundingBox');
subplot(286);imshow(C)
for m=1:length(STATS)
rectangle('Position', STATS(m).BoundingBox, ...
        'EdgeColor','r');
end

D=C;
for m=1:length(STATS)
   k= STATS(m).BoundingBox;
D(k(2)+.5:k(2)-.5+k(4),k(1)+.5:k(1)-.5+k(3))=1;
end
subplot(287);imshow(D)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img=imread('044.bmp');
subplot(289);imshow(img)
level=graythresh(img);
B=im2bw(img,level);
subplot(2,8,10);imshow(B)
B=~B;
subplot(2,8,11);imshow(B)
%%%
CC = bwconncomp(B);
L = labelmatrix(CC);
cind=regionprops(CC,'Area');

map=autumn(350);
RGB = label2rgb(L, map([cind.Area],:));
subplot(2,8,12);imshow(RGB)


img=imread('009.bmp');
B=im2bw(img,level);
B=~B;
CC = bwconncomp(B);
L = labelmatrix(CC);
cind=regionprops(CC,'Area');
RGB = label2rgb(L, map([cind.Area],:));
subplot(2,8,13);imshow(RGB)

img=imread('057.bmp');
B=im2bw(img,level);
B=~B;
CC = bwconncomp(B);
L = labelmatrix(CC);
cind=regionprops(CC,'Area');
RGB = label2rgb(L, map([cind.Area],:));
subplot(2,8,14);imshow(RGB)