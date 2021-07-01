% 模拟从文件中读取图片
%% 事先将准备好的图片 I 写入 war3.dat 
% fileID = fopen('war3.dat','w');
% fwrite(fileID, uint8(I),'uint8');
% fclose(fileID);
x = 133; y = 681; w = 255; h = 210; % 关于图片I的一些预定义参数
Rteam = [255 3 3] ; Bteam =  [0 66 255];



while true
    %pause(10)
    %break
    
    IMG = uint8( permute(m.data.img,[3,2,1]) );
    if IMG(19,237,1)~=222 || IMG(19,237,2)~=202 || IMG(19,237,3)~=37
        disp('wrong capture!')
        continue
    end
    g=sum(I,3) == 765; %255*3;
    %%
    Rt = IMG(:,:,1)==Rteam(1) & IMG(:,:,2)==Rteam(2) & IMG(:,:,3)==Rteam(3);
    Bt = IMG(:,:,1)==Bteam(1) & IMG(:,:,2)==Bteam(2) & IMG(:,:,3)==Bteam(3);
    S =  IMG(:,:,1)==255 & IMG(:,:,2)==255 & IMG(:,:,3)==255;
    imshow(IMG)

    break
end