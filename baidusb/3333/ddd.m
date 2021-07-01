% ·ÖË®ÁëÍ¼Ïñ·Ö¸îbwareaopen bwdist watershed

figure(1)
subplot(231)
A=imread('01.jpg');
imshow(A)
%%
subplot(232)
%imhist(A(:,:,1));
bw=im2bw(rgb2gray(A),.9);
bw=medfilt2(bw);
planes=bwareaopen(bw,500);
imshow(planes)
%%
subplot(233)
D=bwdist(imcomplement(planes));
D=mat2gray(D);
imshow(D)
figure
subimage(D)
hold on
[C,h]=imcontour(D,0.2:0.2:0.8);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
text_handle = clabel(C,h,'color','g');
figure(1)
%%
subplot(234)
M=imimposemin(imcomplement(D),D>.8);
imshow(M);
%%
subplot(236)
L=watershed(M);
r=L & planes;
imshow(r)
%%%%%%%%%%%%
stats=regionprops(r,'BoundingBox','Centroid');

hold on
c=cat(1,stats.Centroid);
plot(c(:,1),c(:,2),'r*')
bb={stats.BoundingBox};
cellfun(@(x) rectangle('Position',x,'EdgeColor','y'),bb)
%%
subplot(235)
L(r)=5;
imshow(L,[])
