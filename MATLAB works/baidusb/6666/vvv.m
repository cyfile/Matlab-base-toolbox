% importdata.m
%------------------------------------------------------
%数据的载人与预处理
%
%-------------------------------------------------------
%%%%%%%%%%%%%%%%
%导入附件二数据
%%%%%%%%%%%%%%%
%红葡萄指标
% [~, ~, raw] = xlsread('F:\A\附件2-指标总表.xls','酿酒葡萄','C3:EK29');
[~, ~, raw] = xlsread('附件2-指标总表.xls','酿酒葡萄','C3:EK29');


R = cellfun(@(x) ~isnumeric(x) || isnan(x),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

redgrapetarget = cell2mat(raw);

    temp=redgrapetarget(:,sum(redgrapetarget)~=0);
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=cumsum(z)<70;
    
    mainredgrapetarget=temp*x(:,ind);


%白葡萄指标
% [~, ~, raw] = xlsread('F:\A\附件2-指标总表.xls','酿酒葡萄','C34:EK61');
[~, ~, raw] = xlsread('附件2-指标总表.xls','酿酒葡萄','C34:EK61');

R = cellfun(@(x) ~isnumeric(x) || isnan(x),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

whitegrapetarget = cell2mat(raw);


    temp=whitegrapetarget(:,sum(whitegrapetarget)~=0);
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=find(cumsum(z)<70);
    
    mainwhitegrapetarget=temp*x(:,ind);

%红葡萄酒指标
% [~, ~, raw] = xlsread('F:\A\附件2-指标总表.xls','葡萄酒','C3:AH29');
[~, ~, raw] = xlsread('附件2-指标总表.xls','葡萄酒','C3:AH29');


R = cellfun(@(x) ~isnumeric(x) || isnan(x),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

redwinetarget = cell2mat(raw);


    temp=redwinetarget(:,sum(redwinetarget)~=0);
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=cumsum(z)<85;
    
    mainredwinetarget=temp*x(:,ind);

%白葡萄酒指标
% [~, ~, raw] = xlsread('F:\A\附件2-指标总表.xls','葡萄酒','C33:AH60');
[~, ~, raw] = xlsread('附件2-指标总表.xls','葡萄酒','C33:AH60');


R = cellfun(@(x) ~isnumeric(x) || isnan(x),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

whitewinetarget = cell2mat(raw);

    temp=whitewinetarget(:,sum(whitewinetarget)~=0);
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=cumsum(z)<85;
    
    mainwhitewinetarget=temp*x(:,ind);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%
%导入附件三数据
%%%%%%%%%%%%%%%
%红葡萄芳香物质
% [~, ~, raw] = xlsread('F:\A\附件3-芳香物质.xls','红葡萄');
[~, ~, raw] = xlsread('附件3-芳香物质.xls','红葡萄');
redgrapefrag=zeros(55,27);
for n=5:26+5
    temp=raw(1,n);
    temp=str2num(temp{1}(5:end));
    redgrapefrag(:,temp)=cell2mat(raw(2:56,n));

end
    redgrapefrag(isnan(redgrapefrag))=0;
    
    temp=redgrapefrag';
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=find(cumsum(z)<70);
    
    mainredgrapefrag=temp*x(:,ind);
    
    

%白葡萄芳香物质
% [~, ~, raw] = xlsread('F:\A\附件3-芳香物质.xls','白葡萄');
[~, ~, raw] = xlsread('附件3-芳香物质.xls','白葡萄');

whitegrapefrag=zeros(55,28);
for n=5:27+5
    temp=raw(1,n);
    temp=str2num(temp{1}(5:end));
    whitegrapefrag(:,temp)=cell2mat(raw(2:56,n));

end
whitegrapefrag(isnan(whitegrapefrag))=0;

    temp=whitegrapefrag';
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=find(cumsum(z)<70);
    
    mainwhitegrapefrag=temp*x(:,ind);
%红葡萄酒芳香物质
% [~, ~, raw] = xlsread('F:\A\附件3-芳香物质.xls','红葡萄酒');
[~, ~, raw] = xlsread('附件3-芳香物质.xls','红葡萄酒');

redwinefrag=zeros(73,27);
for n=5:26+5
    temp=raw(1,n);
    temp=str2num(temp{1}(5:end));
    redwinefrag(:,temp)=cell2mat(raw(2:74,n));

end
    redwinefrag(isnan(redwinefrag))=0;
    
        
    
    temp=redwinefrag';
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=find(cumsum(z)<70);
    
    mainredwinefrag=temp*x(:,ind);

%白葡萄酒芳香物质
% [~, ~, raw] = xlsread('F:\A\附件3-芳香物质.xls','白葡萄酒');
[~, ~, raw] = xlsread('附件3-芳香物质.xls','白葡萄酒');

whitewinefrag=zeros(73,28);
for n=5:26+5
    temp=raw(1,n);
    temp=str2num(temp{1}(5:end));
    whitewinefrag(:,temp)=cell2mat(raw(2:74,n));

end
    whitewinefrag(isnan(whitewinefrag))=0;
    
   

    temp=whitewinefrag';
    temp=zscore(temp);
    r=corrcoef(temp);  %计算相关系数矩阵 
    [x,y,z]=pcacov(r); 
    ind=find(cumsum(z)<70);
    
    mainwhitewinefrag=temp*x(:,ind);