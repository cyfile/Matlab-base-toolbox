% Airy disk
k1=fspecial('disk',10);
sum(k1(:))
genfigure(k1)
%
k2 = double(k1>0);
k2 = k2/sum(k2(:));
sum(k2(:))
genfigure(k2)
%%
function genfigure(kk)
figure
a=zeros(256);
a(118:138,118:138)=kk; %./max(k(:));
A=fftshift(abs(fft2(a)));
%%
subplot(231)
%mesh(kk)
surf(kk)
axis tight
%
subplot(234)
imshow(a,[])
%%
subplot(232)
imshow(log(A),[])
%
subplot(235)
imshow(A,[min(min(A)),.5*max(A(:))])
%%
subplot(233)
mesh(A(1:4:end,1:4:end))
axis tight
%
subplot(236)
mesh(A(132:4:end,:),'meshstyle','row');
axis tight
view([0,-1,0])
%%
colormap(hot)
end