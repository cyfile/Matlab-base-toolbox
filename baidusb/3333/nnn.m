% Single hole diffraction(fft2 imfilter)
figure;
subplot(231)
SE=strel('disk', 10, 0);
imshow(getnhood(SE))
%%%%
subplot(232)
a=zeros(256);
a(128,128)=1;
IM2=imdilate(a,SE);
imshow(IM2)
%%%%
subplot(233)
A=fft2(IM2);
imshow(abs(A))
%%%%
h=subplot(234);
B=fftshift(abs(A));
imshow(B,[min(min(B)),2*min(max(B))])%,...
    %'Colormap',autumn)
%%%%
subplot(235)
imshow(B,[min(min(B)),max(max(B))])
%%%%
subplot(236)
mesh(B(132:4:end,:),'meshstyle','row');
axis tight
view([0,-1,0])
%%%%
%%
figure;
mesh(B(1:3:end,1:3:end))
axis tight
%%
%%%%
figure


[f1,f2] = freqspace(256,'meshgrid');
r = sqrt(f1.^2 + f2.^2);
%%%%
subplot(331)
Cl=real(ifft2(A.*(r>.5)));
imshow(Cl,[min(min(Cl)),max(max(Cl))])
axis([100 156 100 156])
%%%%
subplot(332)
Ch=real(ifft2(A.*(r<.5)));
imshow(Ch,[min(min(Ch)),max(max(Ch))])
axis([100 156 100 156])
%%%%
subplot(333)
C = Cl+Ch;
imshow(C,[min(min(C)),max(max(C))])
axis([100 156 100 156])
%%%%
subplot(325)
hl = ftrans2(fir1(12,0.5));
freqz2(hl);

subplot(326)
hh = ftrans2(fir1(12,0.5,'high'));
freqz2(hh);
%%%%
subplot(334)
Dl = imfilter(IM2,hl);
imshow(Dl,[min(min(Dl)),max(max(Dl))])
axis([100 156 100 156])
axis on
%%%%
subplot(335)
Dh= imfilter(IM2,hh);
imshow(Dh,[min(min(Dh)),max(max(Dh))])
axis([100 156 100 156])
%%%%
subplot(336)
D=imadd(Dl,Dh);
imshow(D,[min(min(D)),max(max(D))])
axis([100 156 100 156])
%%
figure;
imshow(B,[min(min(B)),2*min(max(B))],...
    'Colormap',autumn)
imshow(B,[min(min(B)),2*min(max(B))],...
    'Colormap',hot)
surf(B,'edgecolor','none')