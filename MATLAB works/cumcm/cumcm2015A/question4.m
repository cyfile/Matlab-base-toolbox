xyloObj = VideoReader('movie.avi');
xyloObj.FrameRate
video1 = read(xyloObj,54*25);
video2 = read(xyloObj,54*25+5*60*25);
fr1=video1(800:end,800:end,:);
fr2=video2(800:end,800:end,:);
subplot(321)
imshow(fr1)
subplot(322)
imshow(fr2)
%%
Z = imsubtract(fr2,fr1);
a=im2bw(Z(:,:,1), 5/255);
%imshow(a),imcontrast(gca)
b=im2bw(Z(:,:,2), 5/255);
c=im2bw(Z(:,:,3), 5/255);
D=a&b&c;
BW = bwareaopen(D, 100);

subplot(323)
imshow(D)
subplot(325)
imshow(BW)
%%
%hough ±‰ªªºÏ≤‚œﬂ∂Œ∂Àµ„

theta=87:0.02:89.5;
[H,T,R] = hough(BW,'RhoResolution',1,'Theta',theta);

subplot(324)
imshow(H,[],'XData',T,'YData',R)
axis normal on

peaks = houghpeaks(H);
lines = houghlines(BW, T, R, peaks)
xy = [lines.point1; lines.point2];

subplot(326)
imshow(BW)
hold on
plot(xy(:,1),xy(:,2)+20,'LineWidth',1,'Color','green');
% Plot beginnings and ends of lines
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%%

%%B = imadjust(rgb2gray(imag),[173;210]/255,[0;1]);




