% diffraction
function diffraction

se_d5=strel('disk',5,0);
se_d10=strel('disk',10,0);
se_r5 = strel('rectangle',[20,5]);
se_r3 = strel('rectangle',[20,3]);
se_s = strel('square',10);
showstrel(1,se_d5)
showstrel(2,se_d10)
showstrel(3,se_r5)
showstrel(3,se_r3)
showstrel(4,se_s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
a=zeros(256);
a(128,128)=1;
b=zeros(256);
b(128,[120,136])=1;
c=zeros(256);
c(128,[120,136])=1;
c([120,136],128)=1;
d=zeros(256);
d(128,[104,120,136,152])=1;

%%
figure
I=imdilate(a,se_d5);
aline(1,I)
I=imdilate(a,se_d10);
aline(2,I)
I=imdilate(b,se_d5);
aline(3,I)
%%
figure
aline(1,a)
I=imdilate(a,se_s);
aline(2,I)
I=imdilate(c,se_d5);
aline(3,I)
%%
figure
I=imdilate(a,se_r5);
aline(1,I)
I=imdilate(a,se_r3);
aline(2,I)
I=imdilate(d,se_r3);
aline(3,I)
function showstrel(n,SE)
subplot(2,3,n)
imshow(getnhood(SE))

function aline(k,IM)
%%
subplot(3,4,1+k*4-4)
imshow(IM)
%%%%
subplot(3,4,3+k*4-4)
A=fftshift(abs(fft2(IM)));
imshow(A)
%%%%
subplot(3,4,2+k*4-4)
imshow(A,[min(min(A)),.5*(max(max(A))+min(min(A)))])
%%%%
subplot(3,4,4+k*4-4)
mesh(A(132:4:end,:),'meshstyle','row');
axis tight
view([0,-1,0])

%%%%
return
%%
figure;
mesh(A(1:3:end,1:3:end))
axis tight
%%
figure;
imshow(A,[min(min(A)),2*min(max(A))],...
    'Colormap',autumn)
imshow(B,[min(min(B)),2*min(max(B))],...
    'Colormap',hot)
surf(B,'edgecolor','none')