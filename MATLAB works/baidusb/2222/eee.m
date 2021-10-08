% 解数独(二，浅解数独)
function [T,cluecont,contflag]=solvesudoku_aux(T)
%% 不采用假设，解数独
% 输入有三种：
% 1，无输入，程序载入shuju.txt中的数独
% 2，9×9的由数字0:9构成的数独矩阵
% 3，3×3×3×3×3×3 的由0:10构成的数独矩阵
if nargin ==0 %如果没有输入
    %% 载入数独
    T=dlmread('shuju.txt');
end
if size(T,1)==9 %如果输入是9×9的矩阵
    %% 整理数独数据
    A=T;
    [r,c,v]=find(A);%行，列，数字(r,c,v)
    % drawSudoku([r,c,v])
    % S = sudokuEngine(T); % Solves the puzzle pictured at the start
    % drawSudoku(S)
    cluecont=length(r);
    [d1,d2]=ind2sub([3,3],r);
    [d3,d4]=ind2sub([3,3],c);
    [d5,d6]=ind2sub([3,3],v);
    %% 初始化标记矩阵T
    T=10*ones(3,3,3,3,3,3);
    for k=1:cluecont
        T(:,:,d3(k),d4(k),d5(k),d6(k))=0;
        T(d1(k),d2(k),:,:,d5(k),d6(k))=0;
        T(d1(k),d2(k),d3(k),d4(k),:,:)=0;
        T(:,d2(k),:,d4(k),d5(k),d6(k))=0;
        T(d1(k),d2(k),d3(k),d4(k),d5(k),d6(k))=v(k);
    end
    %% 检查初始数独是否正确
    rslt=sum(reshape(T,9,9,9),3);
    %drawSudoku(rslt)
    rslt(rslt>9)=0;
    if ~isequal(rslt,A)
        error('conflict value')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 按规则填写数字
contflag=zeros(1,10);
fn=1;
foundcont=1;
while foundcont~=0
    foundcont=0;
    for a=1:3
        for b=1:3
            for c=1:3
                for d=1:3
                    %%% 列规则
                    [m,n]=find(T(:,:,a,b,c,d)==10);
                    if length(m)==1
                        T(m,n,:,:,c,d)=0;
                        T(m,n,a,b,:,:)=0;
                        T(:,n,:,b,c,d)=0;
                        T(m,n,a,b,c,d)=c+3*d-3;
                        foundcont=foundcont+1;
                    end
                    %%% 行规则
                    [m,n]=find(reshape(T(a,b,:,:,c,d),3,3)==10);
                    if length(m)==1
                        T(:,:,m,n,c,d)=0;
                        T(a,b,m,n,:,:)=0;
                        T(:,b,:,n,c,d)=0;
                        T(a,b,m,n,c,d)=c+3*d-3;
                        foundcont=foundcont+1;
                    end
                    %%% 格规则
                    [m,n]=find(reshape(T(a,b,c,d,:,:),3,3)==10);
                    if length(m)==1
                        T(:,:,c,d,m,n)=0;
                        T(a,b,:,:,m,n)=0;
                        T(:,b,:,d,m,n)=0;
                        T(a,b,c,d,m,n)=m+3*n-3;
                        foundcont=foundcont+1;
                    end
                    %%% 块规则
                    [m,n]=find(T(:,a,:,b,c,d)==10);
                    if length(m)==1
                        T(m,a,:,:,c,d)=0;
                        T(m,a,n,b,:,:)=0;
                        T(:,:,n,b,c,d)=0;
                        T(m,a,n,b,c,d)=c+3*d-3;
                        foundcont=foundcont+1;
                    end
                end
            end
        end
    end
    contflag(fn)=foundcont;
    fn=fn+1;
   
end