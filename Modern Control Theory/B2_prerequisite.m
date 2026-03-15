% Linear Algebra
%
%

%% ====== computes the inverse of square matrix ======
A = [0 1 ;-2 -3];
A = magic(3);
N=size(A,1)

% --- 模拟 化扩展矩阵为行阶梯型 的 逆矩阵算法 ---
A_e = [A eye(N)]
R = rref(A_e)
R2 = inv(A) * A_e
inv_A = R(:,N+1:end)
% --- matlab 求逆代码 ---
inv_A2 = inv(A)
inv_A3 = A\eye(N)
inv_A4 = A^-1

%% ====== Eigenvalues and eigenvectors ======
A = magic(3);
N=size(A,1);
N=length(A);
% --- 特征值和特征向量的性质 ---
[V,D] = eig(A);
disp('[A*V , V*D] =')
disp([A*V , V*D])
disp('[D , inv(V)*A*V] =')
disp([D , inv(V)*A*V])
% --- 特征向量是非唯一的 ---
V2 = V*diag(rand(1,N))
disp('[A*V2 , V2*D] =')
disp([A*V2 , V2*D])
disp('[A , V2*D*inv(V2)] =')
disp([A , V2*D*inv(V2)])
% --- A阵不能改变特征向量的方向 ---
A*V./V

%%
r = [2,2,3];
N = length(r);
p = poly(r);
A = rot90(compan(p), 2);
[V,D] = eig(A);

% Z = null(V',1); for newer versions of MATLAB
Z = null(V(:,[1,3])')
e = V(:,[1,3])'*Z
A*Z - 2 *Z,V
%%
A =[0 1;-2 -3];
model_order = size(A,1);
[V,D] = eig(A);
% --- 统计重根的出现 及 重根的重数 ---
tbl=tabulate(round(diag(D),5));
if size(tbl,1) == model_order
    disp("full rank")
end

