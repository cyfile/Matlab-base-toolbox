% 读取 由win32 api 函数GetDIBits 获取的图像数据
cx = 256; cy = 210;
%%
fileID = fopen('C:\Users\Administrator\Documents\vscode\Capturing war3\image_original.bin');
fileID = fopen('image_original.bin');
A = fread(fileID,Inf,'*uint8');
fclose(fileID);

b = reshape(A,3,cx,cy) ;
c = permute(b,[3,2,1]) ;
imshow(flip(c, 3 ) )
%%
fileID = fopen('C:\Users\Administrator\Documents\vscode\Capturing war3\image_arranged.bin');
fileID = fopen('image_arranged.bin');
A = fread(fileID,Inf,'*uint8');
fclose(fileID);

imshow(reshape(A,cy,cx,3));
%%
load war3_template.mat
imshow(IMG);
%%
fileID = fopen('image_primitive.bin');
A = fread(fileID,Inf,'*uint8');
fclose(fileID);

b = reshape(A,3,cx,cy) ;
c = permute(b,[3,2,1]) ;
d = flip(c, 3 ) ;
imshow(flip(d, 1 ) )
