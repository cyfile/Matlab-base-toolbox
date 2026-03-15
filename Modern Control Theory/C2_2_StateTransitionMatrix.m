% 2.2 状态转移矩阵
%
% --- 齐次方程的解的计算 ---
% 求解状态转移矩阵 state transition matrix
% 即由 A 求 expm(A*t)
% 课本上给出的都是解析解,这里用数值进行解的验算

clc,clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ====== 幂级数法 ======
%截取原始公式的前几项
model_order=4;
A =rand(model_order);

item_N = 5;
for t = [10,1,0.1]
    expAt = expm(A*t);

    expAt_1 = eye(model_order);
    for k=1:item_N
        expAt_1 = expAt_1 + A^k*t^k/factorial(k);
    end

    a = t.^(0:item_N)./factorial(0:item_N);
    expAt_2 = polyvalm(a(end:-1:1),A);

    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ====== 公式法 ======
% --- 无重根 ---
% 此时A可以对角化,可以带入对角阵的状态转移阵公式
% expm(A*t)=V*diag(exp(diag(D*t)))*inv(V)

% generate A
r = [1,2,3,4];
model_order = length(r);
tmp = rand(model_order);
A = tmp*diag(r)*inv(tmp);

[V,D] = eig(A);
for t = [0.1,1,10]
    expAt = expm(A*t);
    expAt_1=V*diag(exp(diag(D*t)))*inv(V);

    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end

%% -------------------------
% --- 有实重根 ---
% 此时A与实重根jordan块相似,可以带入相应的状态转移阵公式
% expm(A*t)=V*expm(J*t)*inv(V)
%       其中 expm(J*t) 由公式给出

% generate A
lambda = 2;
r = [2,2,2,2];
model_order = length(r);
J = diag(r);
J(diag(true(1,model_order-1),1)) = 1;
% J_P = rot90(compan(poly(r)), 2) ;
tmp = rand(model_order);
A = tmp*J*inv(tmp);

% 求相似变换阵 T
T = zeros(size(A));
T(:,1) = null(A-lambda*eye(model_order));
for k = 1:model_order-1
    T(:,k+1) = pinv(A-lambda*eye(model_order))*T(:,k);
end
check = [J,inv(T)*A*T]

% 带公式
a=triu(toeplitz(0:model_order-1));
b=triu(1./factorial(a));
for t = [0.1,1,10]
    expAt = expm(A*t);
    % t.^a 实际上应该是 triu(t.^a)
    % 这里 b 是一个上三角阵
    % 所以 b.*t.^a = b.* triu(t.^a)
    expAt_1=T*(exp(lambda*t)*b.*t.^a)*inv(T);

    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end

%% -------------------------
% --- 一对共轭根 ---
% 也有公式
%   ┌ α   ω ┐
%   └ -ω  α ┘ 的 expm(A*t) 为
%   ┌  cos(ω*t)  sin(ω*t) ┐
%   └ -sin(ω*t)  cos(ω*t) ┘  * exp( α*t)
% 见最后的 Laplace 变换法 部分

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ====== 应用 Cayley–Hamilton 定理 ======
%  Cayley–Hamilton theorem
A = rand(4);
Y = polyvalm(poly(A),A);
max( abs(Y(:)) )
% 由于 polyvalm(poly(A),A) = 0 所以 A^n 是  A^0 ~ A^(n-1) 的线性组合
% 由于 A * polyvalm(poly(A),A) = 0 所以 A^(n+1) 是  A^1 ~ A^n 的线性组合
%                                       也就是  A^0 ~ A^(n-1) 的线性组合
% 递推可知 expm(A*t) 是 A^0 ~ A^(n-1) 的线性组合

%% -------------------------
% --- 无重根 ---
% expm(A*t)= A^0 ~ A^(n-1) 的线性组合
%        其系数为含t的函数,可由公式给出

% generate A
r = [1,2,3,4];
model_order = length(r);
tmp = rand(model_order);
A = tmp*diag(r)*inv(tmp);

for t = [0.1,1,10]
    expAt = expm(A*t);

    c = inv(fliplr(vander(r))) * exp(r*t)';
    expAt_1 = c(1) * eye(model_order);
    for k=2:model_order
        expAt_1 = expAt_1 + c(k)*A^(k-1);
    end

    a=reshape(ctrb(A,eye(model_order)),4,4,[]);
    b=pagemtimes(a,reshape(c,1,1,[]));
    expAt_2 = sum(b,3);  % same as expAt_1

    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end

%% -------------------------
% --- 有重根 ---
% expm(A*t)= A^0 ~ A^(n-1) 的线性组合
%        其系数为含t的函数,可由公式给出

% generate A
lambda = 2;
r = [2,2,2,2];
model_order = length(r);
J = diag(r);
J(diag(true(1,model_order-1),1)) = 1;
% J_P = rot90(compan(poly(r)), 2) ;
tmp = rand(model_order);
A = tmp*J*inv(tmp);
%%

a_pow = rot90(tril(toeplitz(0:model_order-1)));
n = model_order;
b=reshape([pascal(n);zeros(1,n)],n,[]);
b_cof=rot90(tril(b(:,1:end-1)));

c_pow = (model_order-1:-1:0)';
c_cof = 1./factorial(c_pow);

for t = [0.1,1,10]
    expAt = expm(A*t);

    c = inv(b_cof.*lambda.^a_pow) *  (c_cof.*t.^c_pow)*exp(lambda*t);
    expAt_1 = polyvalm(c(end:-1:1),A);

    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end
%%
t_pow = (0:model_order-1)';
lambda_pow = triu(toeplitz(t_pow));
c_cof = cumprod([ones(1,model_order);lambda_pow(1:end-1,:)]);
check = [diag(c_cof),factorial(t_pow)]'
for t = [0.1,1,10]
    expAt = expm(A*t);

    c = inv(c_cof.*lambda.^lambda_pow) *  (t.^t_pow)*exp(lambda*t);
    expAt_1 = polyvalm(c(end:-1:1),A);

    disp('[expAt   expAt_1] =')
    disp([expAt,expAt_1])
    disp('[t   error] =')
    disp([t, norm(expAt_1-expAt)])
end

%% ====== Laplace 变换法 ======
% expm(A*t) = ilaplace(inv(s*I - A))

% generate A
model_order=2;
w_ = 1; % omega
s_ = (randi(3)-2)/2  % sigma
A = [s_,w_;-w_,s_];
disp(['系统在(0,0)点',  char(13),...
    's=',num2str(s_),' <0 大范围渐进稳定', char(13),...
    's=',num2str(s_),' =0 Lyapunov意义下的稳定', char(13),...
    's=',num2str(s_),' >0 不稳定'])
s=tf('s');
sys = inv(eye(model_order)*s-A);
% minreal(sys,5)

linearSystemAnalyzer('impulse',sys,20);

sys_reduce = tf( ...
    cellfun(@(arr) round(arr,10),sys.Numerator,'UniformOutput',false),...
    cellfun(@(arr) round(arr,10),sys.Denominator,'UniformOutput',false)...
    )

%%
for t = [0.1,1,10]
    % 来自公式
    expAt = [ cos(w_*t) , sin(w_*t); -sin(w_*t)  cos(w_*t) ] * exp(s_*t);

    [y,t_steps] = impulse(sys_reduce,t);
    expAt_1 = shiftdim(y(end,:,:),1) ;

    disp('[expAt   expAt_1] =')
    disp([expAt, expAt_1])
    disp('[t t_steps(end)  error] =')
    disp([t, t_steps(end), norm(expAt_1-expAt)])
end
%%
% A = [α,w;-w,α];
% 等同于 
%    dx1 =  α*x1 + ω*x2 
%    dx2 = -ω*x1 + α*x2
%
% 准备数据
[x1,x2] = meshgrid(-3:.1:3);
dx1 = s_*x1 + w_*x2;
dx2 = -w_*x1 + s_*x2;

quiver(x1,x2,dx1,dx2);
axis tight

%
y = impulse(sys_reduce,0.1);
expAt = shiftdim(y(end,:,:),1) ;
x = [x1(:)';x2(:)'];
dx = expAt * x - x;

l = streamslice(x1,x2, ...
    reshape(dx(1,:),size(x1)),reshape(dx(2,:),size(x2)) ...
    );
set(l,'Color','r');
