% Airy disk
kk=fspecial('disk',10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
a=zeros(256);
a(118:138,118:138)=kk./max(max(kk));
%%%%%%%%%%%%%
subplot(231)
%mesh(kk)
surf(kk)
axis tight
subplot(232)
imshow(a)
subplot(234)
A=fftshift(abs(fft2(a)));
imshow(A)
subplot(233)
imshow(A,[min(min(A)),.5*(max(max(A))+min(min(A)))])
subplot(235)
mesh(A(132:4:end,:),'meshstyle','row');
axis tight
view([0,-1,0])
subplot(236)
mesh(A(1:4:end,1:4:end))
axis tight
colormap(hot)