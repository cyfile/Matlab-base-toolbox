% Color specification in short names
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rgb色彩空间中，g最亮，b最暗，
%三个通道对于亮度的贡献比例接近r:g:b=3:6:1
%详见doc rgb2gray
%double(dec2bin([0:7]))-48
cmat = dec2bin(0:7)-'0';
cmat_n='kbgcrmyw';
%%
[cmap,index] = sortrows(cmat,[-2,-1,-3]);
cmap_n=cmat_n(index);
%%
im=[ones(3,7);8*ones(3,7)];
im([2,5],(2:2:6))=[5:7;2:4];
subplot(5,2,1:2:5)
subimage(im',cmap)
text(2*ones(1,3),2:2:6,num2cell(cmap_n(5:7)),...
    'FontSize',16,'color','w')
text(5*ones(1,3),2:2:6,num2cell(cmap_n(2:4)),...
    'FontSize',16)
subplot(5,2,2:2:6)
subimage(im',rgb2gray(cmap))
%%
subplot(5,2,7:10)
imagesc([0;1])
colormap(gray)
str=num2cell(cmap_n(1:4));
text((10/16:4/16:22/16),ones(1,4),str,...
    'FontSize',16,'Margin',10,...
    {'BackgroundColor'},str')
str=num2cell(cmap_n(5:8));
text((10/16:4/16:22/16),2*ones(1,4),str,...
    'FontSize',16,'Margin',10,...
    {'BackgroundColor'},str',...
    'color','w')