% no title
%% I里的最小值是0，最大值是1

mat2gray(I)  = mat2gray(I,[min(I(:)),max(I(:))])

imshow(I,[]) = imshow(mat2gray(I))

%% I里的像素通过1%的饱和映射到0，1之间

imadjust(I) = imadjust(I,stretchlim(I))    
% maps the intensity values in grayscale image I to new values in J such that 1% of data is saturated at low and high intensities of I.