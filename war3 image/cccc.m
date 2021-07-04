% 模拟从文件中读取图片

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
    
    I=reshape(A,cy,cx,3);
    BW=sum(I,3) == 765; %255*3;
    imshow(BW)
    %%
    interval = [0 -1 0; 1  1  1; 0  -1  0];
    lineH = bwhitmiss(BW,interval);
    pointHH = any(lineH,2);
    pointHV = any(lineH);
    y2 =  find(pointHH);
    
    interval = [0 1 0; -1 1 -1; 0 1 0];
    lineV = bwhitmiss(BW,interval);
    pointVV = any(lineV);
    pointVH = any(lineV,2);
    x2 = find(pointVV);
    
    if numel(y2)>2
        save('war3_template.mat',I);
        error('error,more than 2 row');
    elseif numel(y2)==2
        yc = mean(y2);
    elseif y2 < find(pointVH,1,'first')
        yc = (y2 + find(pointVH,1,'last'))/2;
    elseif y2 > find(pointVH,1,'last')
        yc = (y2 + find(pointVH,1,'first'))/2;
    end
    
    if numel(x2)>2
        save('war3_template.mat',I);
        error('error,more than 2 column');
    elseif numel(x2)==2
        xc = mean(x2);
    elseif x2 < find(pointHV,1,'first')
        xc = (x2 + find(pointHV,1,'last'))/2;
    elseif x2 > find(pointHV,1,'last')
        xc = (x2 + find(pointHV,1,'first'))/2;
    end
    %%
    BW=sum(abs(Iold - Inew ),3)>5;
    Inew(BW,:)
    Inew(BW,:)
    [C,ia,ic] = unique(A(:,1:2),'rows')
    a_counts = accumarray(ic,1);
value_counts = [C, a_counts]
    %%
    Rt = IMG(:,:,1)==Rteam(1) & IMG(:,:,2)==Rteam(2) & IMG(:,:,3)==Rteam(3);
    Bt = IMG(:,:,1)==Bteam(1) & IMG(:,:,2)==Bteam(2) & IMG(:,:,3)==Bteam(3);
    S =  IMG(:,:,1)==255 & IMG(:,:,2)==255 & IMG(:,:,3)==255;
    imshow(IMG)
    
    break
end