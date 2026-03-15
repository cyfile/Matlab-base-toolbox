% 3.3　线性连续定常系统的能观性
%
clear,clc
%
N = 4;      % 状态变量维度
M = 3;      % 输入变量维度 = 输出变量维
%% ====== 一般情况,能观性矩阵的计算
sys_ss = rss(N,M,M) ;
A = sys_ss.A;
C = sys_ss.C;

Ob = obsv(sys_ss) ;
Ob2 = obsv(A,C);
temp = arrayfun(@(k) C*A^k,0:N-1,'UniformOutput',false);
Ob3 = cat(1,temp{:});
Ob4 = cell2mat(temp');
max_error = max(var(cat(3,Ob,Ob2,Ob3,Ob4),0,3),[],'all')

observable = ~logical(length(A) - rank(Ob))

%% ====== 输出维数等于状态维数
% --- 且C非奇异 一定能观.
A = rand(N);
A1 = zeros(N);
C = rand(N);

Ob = obsv(A,C);
observable = ~logical(length(A) - rank(Ob))

Ob = obsv(A1,C);
Ob
observable = ~logical(length(A) - rank(Ob))

%% ====== 输出维数小于状态维数时
% --- A阵为对角阵,C中无全为0的列,则能观.
A = diag(rand(1,N));
C = rand(1,N);
Ob = obsv(A,C);
observable = ~logical(length(A) - rank(Ob))

C = rand(2*N,N);
C(:,randi(N))=0;
Ob = obsv(A,C);
observable = ~logical(length(A) - rank(Ob))

% --- A阵为约旦标准型,C的约旦块开头一列不全为0,则能观.
A = triu(toeplitz([rand,1,zeros(1,N-2)])); 
C = [rand , zeros(1,N-1)];
Ob = obsv(A,C);
observable = ~logical(length(A) - rank(Ob))

