% orphological Operations
orig = imread('snowflakes.png');
se = strel('disk',5);
figure('defaulttextcolor','r')

subplot(321)
imshow(orig)
title('original')
subplot(322)
imshow(bwulterode(orig))
title('bwulterode')
subplot(323)
imshow(imerode(orig,se))
title('imerode')
subplot(325)
imshow(imopen(orig,se))
title('imopen')
subplot(324)
imshow(imdilate(orig,se))
title('imdilate')
subplot(326)
imshow(imclose(orig,se))
title('imclose')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%
a=zeros(30);
a(10:20,10:20)=1;
se = strel('disk',3,0);
%%%%%%%%%%
figure('defaulttextcolor','r')
subplot(241)
imshow(a)
title('original')
subplot(242)
imshow(imerode(a,se))
title('imerode')
subplot(243)
imshow(imopen(a,se))
title('imopen')
subplot(244)
imshow(imtophat(a,se))
title('imtophat')

%%
subplot(245)
imshow(~a)
title('imcomplement')
subplot(246)
imshow(imdilate(~a,se))
title('imdilate')
subplot(247)
imshow(imclose(~a,se))
title('imclose')
subplot(248)
imshow(imbothat(~a,se))
title('imbothat')