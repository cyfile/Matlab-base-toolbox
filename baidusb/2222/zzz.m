% L*a*b* Color Space 图像快速相关

A=double(imread('02.jpg'))/255;
%imshow(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 提取植物叶片
tolab=makecform('srgb2lab');
tosrgb=makecform('lab2srgb');
B=applycform(A,tolab);
%%
lumi=B(:,:,1);
% hist(L(:));
B(:,:,1)=60;
C=applycform(B,tosrgb);
%imshow(C)
%%
[m,n]=size(lumi);
D=reshape(B(:,:,2:3),m*n,[]);
[clus clus_cen] = kmeans(D,2,'distance','sqEuclidean', ...
    'Replicates',3);
clabels = reshape(clus,m,n);
%imshow(clabels,[])
ind=find(diff(clus_cen,1,2)>0);
F=clabels==ind;
%%
G=imdilate(F,strel('disk',2));
G(:,1:30)=0;
H=bwareaopen(G,200);
imshow(H)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 提取框架
B=adapthisteq(rgb2gray(A));
imshow(B)
%%
I=B;
I(H)=0;
imshow(I)
%%
J=imfill(imcomplement(I));
imshow(imcomplement(J))
%%
%imcontrast
K=im2bw(I,0.477);%0.566
imshow(K)
%%
K(:,1:10)=0;
K(:,end-12:end-2)=1;
L=~bwareaopen(~K,60);
imshow(L)
%%
M=imerode(L,strel('disk',9));
imshow(M)
% G=bwareaopen(M,20);
% imshow(G)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 分割区域
P=double(M);
%[I2 rect] = imcrop;
rect=[81.5 61.5 49 52];
PAT=imcrop(P,rect);
PAT=imfilter(PAT,PAT);
%%%%%%%%%%%%%%%%%%%%%%%%%
% % C1=real(ifft2(fft2(B).*fft2(rot90(PAT,2),size(B,1),size(B,2))));
% % C2=real(ifft2(fft2(B).*conj(fft2(PAT,size(B,1),size(B,2)))));
% % %C1,C2都被圆移位了，循环移位
% % imshow(C1,[])
% % imshow(C2,[])
C=imfilter(P,PAT);
D=sqrt(imfilter(P.*P,ones(size(PAT))))+eps;
F=mat2gray(C./D);
imshow(F)
%%
G=F;
G(F<max(F(:))/2.5)=0;
H=imregionalmax(G);
imshow(H)
%%
% % I=bwulterode(F>max(F(:))/1.9);
% % imshow(I)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PAT = fspecial('gaussian',200,30);
mesh(PAT)
C=imfilter(double(H),PAT);
%imshow(C,[])
D=watershed(C);
imshow(D,[])
%%
F=D==0;
G=A;
tmplay=G(:,:,2);
tmplay(F)=1;
G(:,:,2)=tmplay;
imshow(G)
%%%%%%%%%%%%%%%%%%%%%%%%%
return
D=imadjust(C,[0.2 0.7]);
imshow(D)
