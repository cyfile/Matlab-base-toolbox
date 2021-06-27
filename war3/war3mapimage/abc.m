fileID = fopen('war3map.doo','r');
% ftell(fileID)
fseek(fileID, 24, -1);
t_beg=fread(fileID,[2,4],'2*float',42,'l');
% num2hex(single(t_beg))

%%
a=image;
a=a.CData;
b=a>22;
[row,col] = find(b);
len = size(b,1);
A = 32;
B=[A*col(2:192)';-A*row(2:192)'];
%%
fileID = fopen('war3map.doo','r+');
fseek(fileID, 24, -1);
fwrite(fileID,[A*col(1);-A*row(1)],'2*float','l')
fwrite(fileID,B,'2*float',42,'l')
fclose(fileID);
return

%%
A=imread('ted2.png','png');
B=rgb2gray(A);
%imshow(B)
%%
%sobelGradient = imgradient(B);
normal_edges = edge(B,'canny',0.22);
imshow(normal_edges,[])
    
%%

J = medfilt2(B);
K = J(2:2:end,:);
L = K(:,2:2:end);
imshow(L);

n=6;
bb=sort(L(:));
N=length(bb);
N=3060;
bind=linspace(1,N,n);
tick=bb(ceil(bind));
%%
r=[];c=[];
b= L>tick(5) & L<=tick(6); 
[row,col] = find(b);
r=[r;row];c=[c;col];

b= L>tick(4) & L<=tick(5);
b(2:2:end,2:2:end) = false;
[row,col] = find(b);
r=[r;row];c=[c;col];

b= L>tick(3) & L<=tick(4);
b(1:2:end,2:2:end) = false;
b(2:2:end,1:2:end) = false;
[row,col] = find(b);
r=[r;row];c=[c;col];

b= L>tick(2) & L<=tick(3);
b(1:2:end,:) = false;
b(:,1:2:end) = false;
[row,col] = find(b);
r=[r;row];c=[c;col];
%%

fileID = fopen('war3map.doo','r+');
fseek(fileID, 32, -1);
fwrite(fileID,32*[c';-r'],'2*float',42,'l')
fclose(fileID);


