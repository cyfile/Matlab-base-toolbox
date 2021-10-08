% problem1.m
% clc;clear
%%%%%%%%%%%%
%导入附件一数据
%%%%%%%%%%%%
%第一组红葡萄酒品尝评分
% [~, ~, raw] = xlsread('F:\A\附件1-葡萄酒品尝评分表.xls','第一组红葡萄酒品尝评分');
[~, ~, raw] = xlsread('附件1-葡萄酒品尝评分表.xls','第一组红葡萄酒品尝评分');

redwine1g=cell(27,1);
for n=5:14:100
    redwine=raw(n-2,1);
    samp=str2num(redwine{1}(4:end));
    redwine1g{samp} = cell2mat(raw(n:n+9,3:12));
end

for n=102:14:370
        redwine=raw(n-2,1);
    samp=str2num(redwine{1}(4:end));
    try
    redwine1g{samp} = cell2mat(raw(n:n+9,3:12));
    catch
        temp=raw(n:n+9,3:12);
        temp{1,3}=[2];
        redwine1g{samp} = cell2mat(temp);
    end
end

%第二组红葡萄酒品尝评分
% [~, ~, raw] = xlsread('F:\A\附件1-葡萄酒品尝评分表.xls','第二组红葡萄酒品尝评分');
[~, ~, raw] = xlsread('附件1-葡萄酒品尝评分表.xls','第二组红葡萄酒品尝评分');

redwine2g=cell(27,1);
for n=5:14:370
    redwine=raw(n-2,1);
    samp=str2num(redwine{1}(4:end));
    redwine2g{samp} = cell2mat(raw(n:n+9,3:12));
end

%第一组白葡萄酒品尝评分
% [~, ~, raw] = xlsread('F:\A\附件1-葡萄酒品尝评分表.xls','第一组白葡萄酒品尝评分');
[~, ~, raw] = xlsread('附件1-葡萄酒品尝评分表.xls','第一组白葡萄酒品尝评分');

whitewine1g=cell(28,1);
for n=5:13:357
    whitewine=raw(n-1,3);
    samp=str2num(whitewine{1}(4:end));
    whitewine1g{samp} = cell2mat(raw(n:n+9,4:13));
end
whitewine1g{3}(whitewine1g{3}==77)=nan;
whitewine1g{8}(8,9)=nan;

%第二组白葡萄酒品尝评分
% [~, ~, raw] = xlsread('F:\A\附件1-葡萄酒品尝评分表.xls','第二组白葡萄酒品尝评分');
[~, ~, raw] = xlsread('附件1-葡萄酒品尝评分表.xls','第二组白葡萄酒品尝评分');

whitewine2g=cell(28,1);
for n=4:12:329
    whitewine=raw(n,1);
    samp=whitewine{1};
    whitewine2g{samp} = cell2mat(raw(n:n+9,5:14));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
%问题一模型
%%%%%%%%%%%%%%%%%%
%对红葡萄酒进行方差分析
score=cellfun(@sum,redwine1g,'UniformOutput' ,false);
% redscore1g0=cellfun(@mean,score)
redscore1g=cellfun(@(data) sum(data(~isnan(data)))/sum(~isnan(data)),score);
redvar1g=cellfun(@(data) var( data(~isnan(data)) ) ,score);

score=cellfun(@sum,redwine2g,'UniformOutput' ,false);
% redscore2g0=cellfun(@(data) sum(data(~isnan(data)))/sum(~isnan(data)),score);
redscore2g=cellfun(@mean,score);
redvar2g=cellfun(@var ,score);

 

p = anova1([redscore1g redscore2g])

red1gmvar=mean(redvar1g)
red2gmvar=mean(redvar2g)
%----------------------------------------------
%对白葡萄酒进行方差分析
score=cellfun(@sum,whitewine1g,'UniformOutput' ,false);
% redscore1g0=cellfun(@mean,score)
% whitescore1g=cellfun(@mean, score);
% whitevar1g=cellfun(@var, score);
whitescore1g=cellfun(@(data) sum(data(~isnan(data)))/sum(~isnan(data)),score);
whitevar1g=cellfun(@(data) var( data(~isnan(data)) ) ,score);


score=cellfun(@sum,whitewine2g,'UniformOutput' ,false);
whitescore2g=cellfun(@mean, score);
whitevar2g=cellfun(@var ,score);


p = anova1([whitescore1g whitescore2g])

red1gmvar=mean(whitevar1g)
red2gmvar=mean(whitevar2g)