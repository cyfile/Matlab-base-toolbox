% std2 imfilter

A=double(imread('02.jpg'))/255;
imshow(A)
B=adapthisteq(rgb2gray(A));
imshow(B)
%%%%%%%%%%%%%%%%%%%%%%
%% 通过方差(std2)分辨格子框架所在的区域
n=2;
D = blockproc(B,[n n],@(x) std2(x.data)*ones(n));
F=mat2gray(D);
imshow(F)
%%
G=im2bw(F,0.226);
imshow(G)
H=G;
%%
% % 如果有Z（标记叶面位置的矩阵，上个程序里有）的话执行这个cell
% G(end,:)=[];
% H =~G & ~Z;
% imshow(H)
%%
I=bwareaopen(H,13);
imshow(I)
%%
J=imdilate(I,strel('disk',5));
imshow(J)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 通过带阻滤波器 分辨格子框架所在的区域
b= fir1(10,[0.4 0.6],'stop');
freqz(b,1)
h = ftrans2(b);
freqz2(h)
C=imfilter(B,h);
D=mat2gray(C);
imshow(D)
%%
F=im2bw(D,0.477);
imshow(F)
G=F.*~Z;
imshow(G)