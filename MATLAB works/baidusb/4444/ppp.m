% 形心与方位角Orientation Centroid BoundingBox
img=imread('a.jpg');

subplot(2,2,1);imshow(img);
title('原始图像');
huidu=rgb2gray(img);   %%灰度变换
subplot(2,2,2);imshow(huidu);
title('灰度图像');

level=graythresh(huidu);   %%自动计算出一个合适的阈值
[height,width]=size(huidu);
erzhi=im2bw(huidu,level);     %%根据之前得到的阈值对图像进行二值化
subplot(2,2,3);imshow(erzhi);
title('二值化图像');

BW = imfill(erzhi,'holes');
subplot(2,2,4);imshow(BW);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

STATS = regionprops(BW,'BoundingBox','Centroid','Orientation');

rectangle('Position',STATS(1).BoundingBox,'EdgeColor','y')
hold on
plot(STATS(1).Centroid(1),STATS(1).Centroid(2),'*r')

%text(400,300,['\color{blue}',num2str(STATS(1).Orientation),'^o'])
text(360,320,['\color{magenta}',num2str(STATS(1).Orientation),'\circ'])