function P=getClickPoint(I)
BW=sum(I,3) == 765; %255*3;
% imshow(BW)
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

% click: x=[135-343],y=[683-889]  |  war3:xc = [135-343] yc=[683-890]
% click: x=[135-343],y=[683-889]  |  image:xc = [2-210] yc=[2-209]
% A = [(343-135) / (210-2) , 0 ; 0 , (889-683) / (209-2)] ;
% b = [134-1.9712; 683-1.9807]
% b = [135 343;683 889 ]-A*[2 210;2 209] 
A = [(343-135) / (210-2) , 0 ; 0 , (889-683) / (209-2)] ;
b = mean([135 343;683 889 ]-A*[2 210;2 209],2);
[xc;yc]
P=round(A*[xc;yc]+b);
