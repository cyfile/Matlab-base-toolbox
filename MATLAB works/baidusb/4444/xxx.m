% 提取gif动态图片的帧
%这个角色名叫 冲田纱羽





%-------------------------------------------------------------------------------------------------------------------------

imfinfo('a.gif','gif')
[X, map] = imread('a.gif','gif','frames','all');
X2=reshape(X,194,347,7,7);
X2=permute(X2,[1,3,2,4]);
X2=reshape(X2,194*7,[]);
image(X2)
colormap(map)
imwrite(X2,map,'b.jpg','jpg')