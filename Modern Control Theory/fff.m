%% 4.3.1 预备知识




% A=rand(4)
% B=(A+A')/2

n = 5; % 矩阵维度
a = zeros(n);
a(end) = 1;
P_positive_semi_definite = a;
a = randn(n);          % 生成随机n×n矩阵
P_positive_definite = a' * a;
P_negative_definite = - P_positive_definite;
% Negative Semidefinite
%%
P = P_positive_definite;
issymmetric(P)
%% check for positive definite
x=randn(n,12);
v = diag(x'*P*x)';
v2 = diag(x'*-P*x)';
all(v>0)
all(v2<0)
%% Sylvester Criterion
n=length(P);
d=arrayfun(@(k) det(P(1:k,1:k)) ,1:n)
all(d>0)
d2=arrayfun(@(k) det(-P(1:k,1:k)) ,1:n)
sign(d2)
%%
d=eig(P)';
isposdef = all(d > 0)
d2=eig(-P)';
isnegdef = all(d2 < 0)
%%

try R = chol(P);
    norm(R'*R - P)
    disp('Matrix is symmetric positive definite.')
catch ME
    disp('Matrix is not symmetric positive definite')
end
%%
Q = eye(n);
A = -P;
X = lyap(A',Q)
d = arrayfun(@(k) det(X(1:k,1:k)) ,1:n)

Q=eye(2);
A=[0 1 ;-2 -3];
X = lyap(A',Q)
d = arrayfun(@(k) det(X(1:k,1:k)) ,1:2)
%%
A = -P;
B = rand(n,1);
C = rand(1,n);
D = 0;
sys = ss(A,B,C,D);
isstable(sys)