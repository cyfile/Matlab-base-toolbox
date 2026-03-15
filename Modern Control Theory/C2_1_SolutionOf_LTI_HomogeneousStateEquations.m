% 2.1 线性定常齐次状态方程的解(自由解)
%
% dx = A * x
% 的解为
% x = expm(A*t) * x0
% x = expm(A*(t-t0)) * x_t0
% 其中 A 为 状态矩阵 或 系统矩阵
%      expm(A*t) 为 状态转移矩阵 或 矩阵指数函数

%% ====== expm(A*t) 的原始定义 ======
% expAt = I + A*t + (1/2 * A^2 * t^2) + ... + (1/k! * A^k * t^k) + ...
% 
model_order=4;
A =rand(model_order);

item_N = 5;
for t = [10,1,0.1]
    expAt = expm(A*t);

    expAt_1 = eye(model_order);
    expAt_2 = eye(model_order);
    for k=1:item_N
        expAt_1 = expAt_1 + A^k*t^k/factorial(k);
        expAt_2 = expAt_2 + (A*t)^k/factorial(k);
    end

    A_cell=arrayfun(@(k) A^k*t^k/factorial(k),0:item_N,'UniformOutput',false);
    expAt_3 = sum(cat(3,A_cell{:}),3);

    a = arrayfun(@(k) A^k,0:item_N,'UniformOutput',false);
    a_pow = cat(3,a{:});
    a_pow2 = reshape(ctrb(A,eye(model_order)),4,4,[]);
    c_cof = reshape(t.^(0:item_N)./factorial(0:item_N),1,1,[]);
    expAt_4 = sum(a_pow.*c_cof,3); 

    a = t.^(0:item_N)./factorial(0:item_N);
    expAt_5 = polyvalm(a(end:-1:1),A);

    res = cat(3,expAt,expAt_1,expAt_2,expAt_3,expAt_4,expAt_5);
    var(res,0,3)
    
    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end
%%
% 衰减不尽人意
N = 9;
exp_growth = (1:N)'.^(1:N);
fac_growth = factorial(1:N);
semilogy(exp_growth','b');
hold on
semilogy(fac_growth,'r');

%% ================================
N = 4;
A = rand(N);
t = 2; % t1 + t2 = 2
%% ====== 性质一 时间组合性 ======
x1 = expm(A*2);
x2 = expm(A*1.3)*expm(A*0.7);
x3 = expm(A*0.7)*expm(A*1.3);
x4 = expm(A*2.4)*expm(A*-.4);
x5 = expm(A*-1.5)*expm(A*3.5);
x6 = expm(A*0.5)*expm(A*0.5)*expm(A*0.5)*expm(A*0.5);
[x1(:),x2(:),x3(:),x4(:),x5(:)]

%% ====== 性质二 零时不变性  ======
x6 = expm(A*2)*expm(A*0);
isequal(expm(A*0),eye(N)) 

%% ====== 性质三 可逆性  ======
x7 = expm(A*2)*expm(A*-1.9)*expm(A*1.9);
isequal(expm(A*-1.9)*expm(A*1.9),eye(N)) 

%% ====== 性质四 expm(A) 和 A 的可交换性  ======
% 可以根据原始计算式看出来
% expm(A) 原始计算式中的每一项都是 A阵的幂级数形式
% 即原始计算式中的每一项都和 A阵的幂级数可交换
t = rand;
norm(expm(A*t)*A^3-A^3*expm(A*t))
% expm(A) 原始计算式中的每一项都是 
% A阵的幂级数 和 e的泰勒展开的某项的乘积
% A的幂级数中不含t,
% 求导时只需对 含有t的 e的泰勒展开项 进行求导
% 而 e的泰勒展开项 求导后还是 e的泰勒展开项 
% 所以有 d(expm(A*t)) = A*expm(A*t) = expm(A*t)*A

%% ====== 性质五 可交换矩阵组合性  ======
% expm(A*1.3) 和 expm(A*0.7) 可交换
x2 = expm(A*1.3)*expm(A*0.7);
x3 = expm(A*0.7)*expm(A*1.3);
norm(x2-x3)
% A*k1 和 A*k2 显然可交换
% expm(A*k1) 和 expm(A*k2) 可交换
% 仅当 A,B可交换(AB=BA)时 expm(A*t)*expm(B*t) = expm((A+B)*t)
x6 = expm(A*0.5)*expm(A*0.5)*expm(A*0.5)*expm(A*0.5);
x7 = expm(A*1)*expm(A*0.5)*expm(A*0.5);
x8 = expm(A*1.5)*expm(A*0.5);
x1 = expm(A*2);

%% ====== 性质六  ======
% expm(A*t)^k == expm(A*t*k)
x1 = expm(A*2);
x6 = expm(A*0.5)*expm(A*0.5)*expm(A*0.5)*expm(A*0.5);
norm(x1-x6)

%% ====== 性质七  ======
% 相似矩阵
% P 为非奇异矩阵
% dx = A * x 的解 expm(A*t)
% inv(P)*dx = inv(P)*A*P*inv(P)*x 即
% dx_ = inv(P)*A*P*x_ 的解 expm(inv(P)*A*P*t)
% 满足关系 inv(P)*expm(A*t)*P = expm(inv(P)*A*P*t)
t=2;
P=rand(N);
y1 = expm(inv(P)*A*P*t);
y2 = inv(P)*expm(A*t)*P;
norm(y1-y2)