% hough randon fanbeam
n=21;
a=imadd(eye(n),flip(eye(n),1));
a(ceil(n/2),:)=1;
%a(:,ceil(n/2))=1;
iptsetpref('ImshowAxesVisible','on')

subplot(341)
imshow(a)

%%
subplot(3,4,2:4)
[H,T,R] = hough(a,'RhoResolution',0.5,'Theta',-90:0.5:89.5);
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R)%imadjust,带饱和的映射
title('hough 投影平面从y轴开始绕左上角([0,0]点)由顺时针旋转180度')
%%
subplot(3,4,6:8)
theta = 0:180;
[R,xp] = radon(a,theta);
imshow(mat2gray(R),'Xdata',theta,'Ydata',xp)
title('randon 投影平面从x轴开始绕图像中心顺时针旋转180度')
%%
subplot(3,4,10:12)
[F,Fpos,Fangles] = fanbeam(a,2*n);
imshow(mat2gray(F),'XData',Fangles,'YData',Fpos)
title(['fanbeam 投影平面和和点光源始终和图像中心对称，',...
    '并从x轴开始绕图像中心顺时针旋转360度'])
%%
colormap(gca,'hot')