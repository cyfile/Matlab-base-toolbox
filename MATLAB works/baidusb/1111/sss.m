% 拟合
A = imread('2','png');
%%
subplot(151)
I = rgb2gray(A);
imshow(I)
%%
subplot(152)
%imcontrast(gca)
R =imclearborder(im2bw(I,30/255));
imshow(R)
%%
%%%%%%%%%%%%%%%%%%
subplot(153)
CH = bwconvhull(R,'objects');
imshow(CH)

subplot(154)
BWD = imdilate(CH,strel('disk',1));
imshow(BWD)

subplot(155)
BW = bwareaopen(BWD,200);
imshow(BW)
%%
%%%%%%%%%%%%%%%%%%%%%%%
figure

subplot(151)
z=immultiply(BW,I);
%i=I;i(~BW)=0;isequal(z,i)
subimage(z);
axis on;hold on
ax=axis;

subplot(1,5,2:3)
[y_max,x_max]=size(z);
[x,y]=meshgrid(1:x_max,1:y_max);
surface(x,y,double(z),'linestyle','none')
axis(ax)
axis ij;hold on
%%
%%%%%%%%%%%%%%
Z=I(BW);
[Y,X]=find(BW);
STATS = regionprops(BW,'Extrema');
u=mean(STATS.Extrema(1:2,:));
d=mean(STATS.Extrema(5:6,:));
plot([u(1),d(1)],[u(2),d(2)],'.r','markersize',20)
aa=(u(2)-d(2))/(u(1)-d(1));
bb=aa*-d(1)+d(2);
%%%%%%%%%%%%%%
%% 直线拟合
% % cfit1 = fit(X,Y,'poly1','Weights',Z);
% % plot(cfit1,'m')
% % cfit2 = fit(X,Y,'poly1','Weights',double(Z).^2,'Robust','LAR');%,'Robust','Bisquare')
% % plot(cfit2,'g')
% % cfit3 = fit(X,Y,'poly1','Weights',double(Z),'Lower',[10*aa,bb/2],...
% %     'Upper',[aa/2,10*bb]);%,'StartPoint',[aa,bb],'Robust','Bisquare')
% % plot(cfit3,'r')
%%%%%%%%%%%%%%
%% 曲面拟合
%F = @(a,b,x,y) 256*exp(-(y-a*x-b).^2);
fo = fitoptions('Method', 'LinearLeastSquares',...
    'Lower',[-inf,500],...
    'Upper',[-10,inf]);

ft = fittype('256*exp(-(y-a*x-b).^2/6666)',...
    'independent', {'x', 'y'},...
    'dependent', 'z',...
    'coefficients',{'a','b'});%,'c'
%coeffnames(ft)

opts = fitoptions( ft );
opts.Lower = [10*aa,bb/2];%,999
opts.upper = [aa/2,10*bb];%,9999
opts.Robust = 'LAR';
opts.StartPoint = [aa,bb];%,8888
%opts.Exclude =Z<50;

sfit1 = fit([X,Y],double(Z),ft,opts);

%plot(sfit1,[X,Y],Z,'Exclude',Z<50)
%%
subplot(1,5,4:5)
plot(sfit1)
axis ij;hold on;
%
%%
surface(x,y,double(z),'linestyle','none')

subplot(151)
yl=[d(2);u(2)];
xl=(yl-sfit1.b)/sfit1.a;
plot(xl,yl,'g')%,'linewidth',5
subplot(1,5,2:3)
plot3(xl,yl,[300,300],'k','linewidth',2)%
%figure;plot(Z)