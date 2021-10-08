A=imread('ted.jpg');
B=rgb2gray(A);
%%
[A,ind]=imread('fly100.png','png');
RGB=ind2rgb(A,ind);
B=rgb2gray(RGB);
%%
A=imread('Yotsuba.jpg');
B=rgb2gray(A);
%%
% medfilt2(B);
%imshow(B)
C=imcrop(B);
C=B;
%%
D=imresize(C,0.22);

BW = imbinarize(D,'a','Sensitivity',0.7);
imshow(BW)

b=~BW;
N = sum(b(:))
%%
[row,col] = find(b);
len = size(b,1);
c = 16;
xy=c * [col,-row]';
%%


fileID = fopen('war3mapdoo','r+');
fseek(fileID, 24, -1);

fwrite(fileID,xy(1:2),'2*float','l')
fwrite(fileID,xy(3:end),'2*float',42,'l')
fclose(fileID);
return
%%
fileID = fopen('war3mapdoo','r');
fseek(fileID, 24, -1);
% ftell(fileID)

xy=fread(fileID,[2,4],'2*float',42,'l');
num2hex( single( xy ) )
typecast( single( xy(:) ),'uint8')
fclose(fileID);
%%

