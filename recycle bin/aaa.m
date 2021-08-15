n = 16;
a=zeros(16*n);
[x,y]=meshgrid( (1:16*n)-8*n-0.5 ) ;
r= abs(x+1i*y);
a(2*n<r & r<5*n)=1;
h = fspecial('disk',2) ;
a = imfilter(a,h,'replicate'); 
A=abs(fft2(a));
B=fftshift(A);
%%
subplot(221)
imshow(a,[])
%
subplot(222)
%surf(a)
mesh(log(A))
axis tight
%%
subplot(223)
imshow(log(A),[])
%
subplot(224)
imshow(log(B),[])

 %%
% colormap(hot)
