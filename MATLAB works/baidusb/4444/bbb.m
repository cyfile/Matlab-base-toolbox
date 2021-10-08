% morphological structuring element (strel)
figure
subplot(331)
SE=strel('disk', 50, 8);
imshow(getnhood(SE))
subplot(332)
SE=strel('disk', 50, 0);
imshow(getnhood(SE))
subplot(333)
SE=strel('disk',50);
imshow(getnhood(SE))

SEQ=getsequence(SE);
for k=1:length(SEQ)
    subplot(3,3,k+3)
    imshow(getnhood(SEQ(k)))
end