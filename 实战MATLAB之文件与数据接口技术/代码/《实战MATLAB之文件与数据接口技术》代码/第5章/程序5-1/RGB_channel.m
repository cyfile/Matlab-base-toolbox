%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 5-1 RGB_channel.m
function [] = RGB_channel(filename)
% This function is used to get a BMP file's color channels.
% 2011-01-06
if nargin==0
    filename = uigetfile('*.bmp');
end
fid = fopen(filename,'r');
if fid == -1
    disp('ERROR: the file doesnot exist.');
    return;
end
% judge whether the file is a 24-bit BMP file.
fseek(fid,0,'bof');          % Move file position indicator to beginning.
bmpfile_magic = fread(fid,2,'uint8=>char');
bmpfile_magic = bmpfile_magic.';
if strcmp(bmpfile_magic,'BM')==0
    disp('ERROR: the file is not an universal BMP file.');
    return;
end
fseek(fid,10,'bof');
pixel_array_offset = fread(fid,1,'uint32');
if pixel_array_offset ~= 54
    disp('ERROR:the BMP file has a color table!');
    return;
end
fseek(fid,28,'bof');
pixel_bits_num = fread(fid,1,'uint16');
if pixel_bits_num ~= 24
    disp('ERROR:the number of bits per pixel is not 24.');
    return;
end
fseek(fid,30,'bof');
compression_method = fread(fid,1,'uint32');
if compression_method ~= 0
    disp('ERROR: the BMP file used compression method!');
    return;
end
% read the width and the height
fseek(fid,18,'bof');
width_pixel_num = fread(fid,1,'uint32');
height_pixel_num = fread(fid,1,'uint32');

% width_bytes = ceil(width_pixel_num*3/4)*4;
% height_bytes = ceil(height_pixel_num*3/4)*4;

% blue_array = zeros(height_pixel_num,width_pixel_num);
% green_array = zeros(height_pixel_num,width_pixel_num);
% red_array = zeros(height_pixel_num,width_pixel_num);

fseek(fid,54,'bof');
colorData = fread(fid,width_pixel_num*height_pixel_num*3,'uint8'); % read color data
colorData = reshape(colorData,width_pixel_num*3,height_pixel_num);
colorData = colorData.';
colorData = flipdim(colorData,1);

colorData = colorData/max(max(colorData)); % 归一化

blue_array = colorData(:,1:3:end);   % get channel data
green_array = colorData(:,2:3:end);
red_array = colorData(:,3:3:end);

% for ii = 0:height_pixel_num-1
%     fseek(fid,54+ii*width_bytes,'bof');
%     blue_array(height_pixel_num-ii,:) = fread(fid,width_pixel_num,'uint8',2);
%     fseek(fid,55+ii*width_bytes,'bof');
%     green_array(height_pixel_num-ii,:) = fread(fid,width_pixel_num,'uint8',2);
%     fseek(fid,56+ii*width_bytes,'bof');
%     red_array(height_pixel_num-ii,:) = fread(fid,width_pixel_num,'uint8',2);
% end  %本循环读取顺序更改： 由R、G、B更改为B、G、R，2011-07-10

figure;
imagesc(blue_array);%,[min(min(blue_array)) max(max(blue_array))]);
colormap(gray);
title('blue channel');

figure;
imagesc(green_array);%,[min(min(green_array)) max(max(green_array))]);
colormap(gray);
title('green channel');

figure;
imagesc(red_array);%,[min(min(red_array)) max(max(red_array))]);
colormap(gray);
title('red channel');

fclose(fid);
end
