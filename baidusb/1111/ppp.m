% Detect Lines in Images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
A = imread('2','png');
%%
subplot(231)
I = rgb2gray(A);
imshow(I)
%%
subplot(2,3,2:3)
[H,T,R] = hough(I);
imshow(H,[],'XData',T,'YData',R,...
    'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
%%
subplot(2,3,5:6)
tr=1;
theta=85:tr:90-tr;
[H,T,R] = hough(I,'RhoResolution',1,'Theta',theta);
imshow(H,[],'XData',T,'YData',R)
% 'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
%%
P  = houghpeaks(H,9,'threshold',ceil(0.4*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','r');
% Find lines and plot them
lines = houghlines(I,T,R,P,'FillGap',100,'MinLength',20);
%%
subplot(234)
imshow(I)
hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end