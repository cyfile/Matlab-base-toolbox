% 1.5 状态矢量的线性变换
%
%
%
clc,clear
%% ====== 状态空间表达式的非唯一性 ======
% --- 系统的非奇异变换 ---
N = 4;
sys = rss(N,3,2);
T = rand(N); % 随机可逆变换矩阵
%  x_t = T*x
sys_t = ss2ss(sys,T);

A = T * sys.A * inv(T); 
B = T * sys.B;
C = sys.C  * inv(T);
D = sys.D;
%
zpk(sys-sys_t).K

norm(A-sys_t.A,1)
norm(B-sys_t.B,1)
norm(C-sys_t.C,1)
norm(D-sys_t.D,1)

% --- 系统经过非奇异变换,传递函数不变 ---
disp("  ------ W(s) == W2(s) -------")
sys_validation = parallel(tf(sys) , -tf(sys_t) );
max_numerator = max(cell2mat(sys_validation.Numerator),[],"all")
sys_temp = minreal(sys - sys_t);
sys_is_static = isstatic(sys_temp)
sys_temp.D

% --- 系统经过非奇异变换,特征值不变 ---
% 因为 A_new = T * sys.A * inv(T), 所以非奇异变换仅对状态阵A进行相似变换
% 而新旧矩阵都相似于同一个 jordan 标准型, 故系统特征值不变
[pole(sys) pole(sys_t)]
[eig(sys.A) eig(sys_t.A)]


%% ====== 化状态阵A为约旦标准型 ======
% 化为jordan标准型的方法就是找到变换阵 T 对A进行相似变换
% J = T*A*inv(T)
% A按其特征多项式的根的情况可以分为 无重根,实重根,共轭复根
% A按其形式可以分为 任意形式,和标准型(系统为能观标准I型)
%                   其中标准型为友矩阵形式, 求T有公式

%% --------- 无重根 ---------
% generate A
lambda = [1,2,3,4];
model_order = length(lambda);
D0 = diag(lambda);
V0 = rand(model_order);
A = V0*D0*inv(V0);
% 任意形式的A 变换为约旦标准型
[V,D] = eig(A);
[d,ind] = sort(diag(D));
Ds = D(ind,ind);
Vs = V(:,ind);% T = Vs
A_jordan = inv(Vs)*A*Vs
check = Vs./V0 % 因为特征向量可以任意长度 所以 check 的每列都相同
% ----------------------
% generate A_companion 
c = compan(poly(A));
A_c = rot90(c, 2);
A_c2 = fliplr(flipud(c));
t=flipud(eye(model_order));
A_c3 = t*c*t;
% A_c = A_c2 = A_c3
disp("check for lambda [lambda ; roots(poly(A_c)] = ")
disp([lambda ; roots(poly(A_c))'])
A_companion=A_c;
% 标准型(能观I型)的 A 变换为约旦标准型
% 其特征向量存在公式
T = rot90(vander(lambda));
A_jordan = inv(T)*A_companion*T
T2= T(:,randperm(model_order));
check = round(inv(T2)*A_companion*T2,4)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% --------- 重根 ---------
% generate A
lambda = [2,2,2,2];
model_order = length(lambda);
A0 = compan(poly(lambda));
V0 = rand(model_order);
A = V0*A0*inv(V0);
% 任意形式的A 变换为约旦标准型
A_minusLambda = A - diag(lambda);
T = zeros(size(A));
T(:,1) = null(A_minusLambda);
for k = 1:model_order-1
    T(:,k+1) = pinv(A_minusLambda)*T(:,k);
end
A_jordan = inv(T)*A*T
% ----------------------
% generate A_companion 
A_companion = rot90(A0, 2);
% 标准型(能观I型)的 A 变换为约旦标准型
% 其变换阵存在公式
n=model_order;
a=tril(toeplitz(0:n-1));
b=cumprod([ones(n,1),a(:,1:end-1)],2);
c=b./diag(b)';

b=reshape([pascal(n);zeros(1,n)],n,[]);
c2=tril(b(:,1:end-1));
disp("get c via 2 approaches [c , c2] = ")
disp([c , c2])

T=c.*tril(lambda(1).^a);
A_jordan = inv(T)*A_companion*T

%%
% 标准型(能观I型)的 A 变换为约旦标准型
% 此时之所以不能用 特征根的 Vandermonde矩阵构建特征向量阵
% 是因为特征根为重根,构造的Vandermonde矩阵每列都一样,秩为1
% 但是可以取Vandermonde矩阵的一列做为初始的广义特征向量
% 然后将 A 看成一般矩阵,用一般方法求得其他的广义特征向量
T2 = zeros(model_order);
T2(:,1) = lambda(1).^(0:model_order-1);
A_companion_minusLambda = A_companion - diag(lambda);
for k = 1:n-1
    T2(:,k+1) = pinv(A_companion_minusLambda)*T2(:,k);
end
A_jordan = inv(T2)*A_companion*T2
% ------ check ------
disp('[T , T2] =')
disp([T , T2])

v01 = (A_companion_minusLambda)*T(:,1);
v02 = (A_companion_minusLambda)*rand*T(:,1);

v11 = T(:,1);
v12 = (A_companion_minusLambda)*T(:,2);
v13 = (A_companion_minusLambda)*T2(:,2);
v14 = (A_companion_minusLambda)*(T(:,2)+rand*T(:,1)); 
v15 = (A_companion_minusLambda)*(T2(:,2)+rand*T(:,1));
% 特征向量是非唯一的,广义特征向量也是非唯一的
% 比如说 rand*T(:,1) 可以代替第一个广义特征向量
%       T(:,2)+rand*T(:,1) 都可以代替第二个特征向量
check = [v01,v02]
check = [v11,v12,v13,v14,v15]
% 但 广义特征向量 需配套使用

%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% --------- 共轭复根 ---------
sigma = 2;omega=pi/3;
sigma=-2;omega=1;
lambda=[sigma+omega*1i,sigma-omega*1i];
p = poly(lambda);
A_companion = rot90(compan(p),2)
% 此时 A 为标准型(能控标准I型) 可以带公式 求变换阵T
T=[1,0;sigma,omega];
A_jordan = inv(T)*A_companion*T
% -----------
% 矩阵理论上jordan块里的元素可以是复数.此时共轭复根相当于无重根的情况
% 不过在规定jordan块里的元素必须为实数的情况下,共轭复根做为一种单独的情况存在.
A = [sigma,omega;-omega,sigma];
[V,D]=eig(A)
A_jordan = inv(V)*A*V


%% ====== 系统的jordan块并联实现 ======
% 任意系统的jordan标准型就是上述各种形式的jordan块组合成的分块对角阵
% 每个jordan块都可以构成独立的一个系统
% 任意系统都可以将 其包含的各个jordan块分别构成系统后 再通过并联实现

lambda = [0 7 -10 -10 3+4i 3-4i 3+4i 3-4i];
sys = zpk([1 -1],lambda,100);
%   doc modalreal  % for matlab R2023b or later
[sys_canon,T] = canon(sys,'modal',1) ;
A = sys_canon.A;

%
tbl=tabulate(round(lambda,5))
cellArray = arrayfun(@(a,b) gallery('jordbloc', a, b), tbl(:,2), tbl(:,1), ...
    'UniformOutput', false);
A_jordan = blkdiag(cellArray{:});

% ------ check ------
lambda_2 = roots(poly(A));
lambda_3 = roots(poly(A_jordan));

setxor(round(lambda,5),round(lambda_2,5))
setxor(round(lambda,5),round(lambda_3,5))

