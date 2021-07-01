% Projective transformation
im = imread('02.jpg');
imshow(im);
%%%*********************************
%%
% % h = imrect(gca);%[I rect]= imcrop;
% % rect = wait(h);
rect=[100 520 1625 1505];

im_s= imcrop(im,rect);
subplot(221)
imshow(im_s)

% 观察图像背景是由含有红色和绿色成分的黄色，
% 故用蓝色层生成灰度图像。
BW=im2bw(im_s(:,:,3),0.6);
subplot(222)
imshow(BW)

BW = imfill(BW,'holes');
subplot(223)
imshow(BW)

% % [x, y] = getpts(gca)
% % h = impoint(gca,fliplr(size(BW)/2));
% % p = wait(h);
p=size(BW)/2;
%I=medfilt2(BW,[11,11]);
I = bwselect(BW,p(2),p(1),4);
subplot(224)
imshow(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % IM2 = imclearborder(I);
% % figure
% % imshow(I2)
% %
% % I2=ordfilt2(I,1,ones(7));
% % I2=ordfilt2(I2,9,ones(7),'symmetric');
%%%***********************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% corner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I_c=medfilt2(I,[9,9]);
%%
imshow(I_c)
%k=fspecial('gaussian',[61 1],500);
%k=[k(16:end);k(2:15);k(16)];
k=ones(61,1);
%surf(k*k')
C = corner(I_c,'MinimumEigenvalue',10,...
    'FilterCoefficients',k,...%ones(51,1)
    'QualityLevel',.5);%,...);%
% C = corner(I_c,10,...
%     'FilterCoefficients',k,...%ones(51,1)
%     'QualityLevel',.7,...);%,
%     'SensitivityFactor',0.24);
hold on
plot(C(1:4,1), C(1:4,2), 'r*');
%plot(C(:,1), C(:,2), 'r*');
hold off
%%%***********************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bwtraceboundary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=round(size(I)/2);
tml=find(I(p(1):end,p(2))==0,1,'first');
%I(p(1)+tml-2,p(2))
p(1)=p(1)+tml-2;
B = bwtraceboundary(I,p,'N');
subplot(223)
hold on

plot(B(:,2),B(:,1),'g','LineWidth',2);
plot(p(2),p(1),'rx','LineWidth',2)
max(B);
min(B);

%%%***********************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regionprops
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
STATS = regionprops(I,'Extrema');
tmpk=STATS.Extrema;
tmpl=diff(tmpk);
tmpl=sum(tmpl(1:2:end,:),2)/2;
C4=tmpk([1,4,5,8],:)+[tmpl,-tmpl];
subplot(222)
%imshow(I)
hold on
impoly(gca,C4);
%%
%%%%%%
subplot(221)
h = impoly(gca,C([4,3,2,1],:));
% % input_points = wait(h);
% % %input_points=C4;
% % %input_points = [663 32;1583 186;1290 1448;20 1098];
input_points = C([4,3,2,1],:);

A4paper=[210 297]*5;
n=A4paper(1);
m=A4paper(2);
base_points=[0 0;n 0;n m;0 m];

 

tform = maketform('projective',input_points,base_points);
%tform = cp2tform(input_points,base_points,'projective');
[B,xdata,ydata] = imtransform(im_s, tform,'bicubic',...
    'XData',[0 n], 'YData',[0 m]);
figure
imshow(B)
%%
cpselect(im_s,B,input_points,base_points)

%%%%%%
imwrite(B,'03.jpg','jpg')
%imextendedmax