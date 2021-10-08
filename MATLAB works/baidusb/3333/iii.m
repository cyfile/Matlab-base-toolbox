% checkerboard imnoise
A= checkerboard(25,2);
subplot(341)
imshow(A)
subplot(342)
imhist(A)
axis tight
subplot(343)
B=imnoise(A,'gaussian',0,0.02);
imshow(B)
subplot(344)
imhist(B)
%%%%%%
subplot(345)
C=imnoise(A,'sa',0.02);
imshow(C)
subplot(346)
imhist(C)
axis tight
%%%%%%
subplot(347)
C=imnoise(A,'po');
imshow(C)
subplot(348)
imhist(C)
axis tight
%%%%%%
subplot(349)
C=imnoise(A,'sp',0.2);
imshow(C)
subplot(3,4,10)
imhist(C)
%%%%%%
% subplot(3,4,11)
% C=imnoise(A,'un',0.2);
% imshow(C)
% subplot(3,4,10)
% imhist(C)
% axis tight