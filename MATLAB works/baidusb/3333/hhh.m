% roicolor imadjust stretchlim histeq adapthisteq wiener2 fspecial
im = imread('03.jpg');
I = rgb2gray(im);
imshow(I)
%%%%
stretchlim(I,0)
BW = roicolor(I,0.7*255,255);
imshow(BW)
BW2=ordfilt2(BW,5,ones(3));
imshow(BW2)
I(BW2)=255;
imshow(I)
%%%%
J = imadjust(I);
[counts,x] = imhist(J);
plot(x(2:end-1),counts(2:end-1))
J2 = imadjust(J,[0,150/256]);
%J2=histeq(J,64);
imshow(J2)
%%%%
K = adapthisteq(J2...);
    ,'NumTiles',[8 8]...
    ,'ClipLimit',.1...
    ,'Distribution','exponential'...
    ,'Alpha',.4);
imshow(K)
%%%%
h = fspecial('gaussian',[5 5],.4);
L= imfilter(K,h);
imshow(L)
%%%%
M = imadjust(L,[0.1,0.9]);
imshow(M)
%%%%%%%%%%%%%%%%%%%%%%
return
%%%%%%%%%%%%%%%%%%%%%%
%%%%
h=ftrans2(fir1(4,.5,'high'));
h=fspecial('unsharp');
K=imfilter(J2,h);
%stretchlim(K)
imshow(K)
%%%%
[I,psf]=deconvblind(J2,ones(7),20);
%%%%
J = wiener2(M);
imshow(J)
%%%%
imcontour(I)
%%%%%%%%%%%
imextendedmax