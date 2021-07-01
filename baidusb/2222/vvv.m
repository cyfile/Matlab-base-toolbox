% Hough transform
function aaa
%
t=zeros(20);
%
onep=[1,20,400-20+1,400];
for k=1:4
    a=t;a(onep(k))=1;
    lineplot(2*k-1,a)
end
a=t;a(onep)=1;
lineplot(9,a)
%%%%%%%%%%%%%%%%%%%%%%%%
a=t;a(:,10)=1;
lineplot(2,a)
%
a=t;a(10,:)=1;
lineplot(4,a)
%
a=t;a(6:15,10)=1;
lineplot(6,a)
%
a=t;a([1:5,16:20],10)=1;
lineplot(8,a)
%%
n=20;
t=zeros(2*n+1);
t(n,n)=1;
a=t;
dik_in=imdilate(a,strel('disk',ceil(n/2)));
dik_out=imdilate(a,strel('disk',ceil(n/2)+1));
b=dik_out-dik_in;
lineplot(10,b)
%%
figure;
n=100;
t=zeros(2*n+1);
t(n,n)=1;
a=t;
dik_in=imdilate(a,strel('disk',ceil(n/2),0));
dik_out=imdilate(a,strel('disk',ceil(n/2)+2,0));
b=dik_out-dik_in;
subplot(211)
imshow(b)
subplot(212)
[H,T,R] = hough(b);
imshow(mat2gray(H),'XData',T,'YData',R...
    ,'InitialMagnification','fit');
axis on, axis normal;
colormap(hot)
function lineplot(k,im)

subplot(5,6,1+3*(k-1))
imshow(im)

subplot(5,6,(2:3)+3*(k-1))
[H,T,R] = hough(im);
imshow(mat2gray(H),'XData',T,'YData',R...
    ,'InitialMagnification','fit');
axis on, axis normal;
colormap(hot)