% 提取颜色代码 获取matlab调色板颜色代码
A = imread('syscolor', 'bmp');
image(A)
axis image 
[y,x] = ginput(1);
a=A(round(x),round(y),:);

['#',reshape(dec2hex(a)',1,[])]

 

imtool('syscolor.bmp')

c = uisetcolor;