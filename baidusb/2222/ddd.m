% 解数独(三，递归解数独)
http://www.mathworks.cn/company/newsletters/articles/solving-sudoku-with-matlab.html

function [outM,m]=sudoku_r(M)%,rightflag
% 递归解数独 (需要调用solvesudoku_aux)

%% 用n记录本函数递归调用的次数
persistent n
%dbstack
if size(M,1)==9
    n=1;
else
    n=n+1;
end

%%-----------------------------------------------
%%
outM={};%初始化(默认)输出

T=solvesudoku_aux(M);%填写不用假设就可以填写的数值

%% 找到某个可填数字最少的小格，将其可填数字的位置标记记录进entry
Ttmp=reshape(T,81,9);
tmp=sum(Ttmp,2);
tmp(tmp<10)=100;
[val,ind]=min(tmp(:));
if val==100 % 如果无法继续填写数字
    if  sum(T(:))==405;%9*sum(1:9) %如果所有的空格都被填满
        outM={T};
    end
    return
end

w=find(Ttmp(ind,:));
entry=ind+81*(w-1);

%% 假设该数字在该列的位置，进行试探
for k=entry
    T(entry)=0;
    T(k)=10; % 更新数独得到新的数独题目
    % tmp=reshape(T,9,9,9);
    % drawSudoku(sum(reshape(T,9,9,9),3))
    M=sudoku_r(T); %进行递归
    outM=[outM,M]; %记录结果
end

m=n;
%%%%%%%%%%%%%%%%%%%%%%%%%%%