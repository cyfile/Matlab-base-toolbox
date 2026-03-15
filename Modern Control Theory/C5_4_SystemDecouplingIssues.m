% 5.4 系统解耦问题
% ----------------
% 本脚本实现与验证系统的两种解耦方法：
% 1. 前馈补偿器解耦
% 2. 状态反馈解耦
%
%  doc modalreal  % for matlab R2023b or later
%
% ####################
clc; clear; close all;
showApp = false;
%% ====== 系统参数配置 ==================
sys_choice = 3;
switch sys_choice
    case 1
        N = 4;      % 状态变量维度
        M = 3;      % 输入变量维度 = 输出变量维度
        % 随机生成系统矩阵
        V = rand(N);
        A = V*diag( ...
            [-0.8848 + 1.5509i
            -0.8848 - 1.5509i
            -0.7975 + 0.0000i
            -0.5355 + 0.0000i] ...
            )/V ;       % 状态转移矩阵
        B = rand(N, M);    % 输入矩阵
        C = rand(M, N);    % 输出矩阵
        D = zeros(M, M);   % 直接传递矩阵（设为零）

        % 构建系统
        sys_ss = ss(A,B,C,D);
        sys_tf = tf(sys_ss);
    case 2
        N = 4;      % 状态变量维度
        M = 2;      % 输入变量维度 = 输出变量维度
        A = [0 1 0 0; 3 0 0 2; 0 0 0 1; 0 -2 0 0];
        B = [0 1 0 0; 0 0 0 1]';
        C = [1 0 0 0; 0 0 1 0];
        D = zeros(2);

        % 构建系统
        sys_ss = ss(A,B,C,D);
        sys_tf = tf(sys_ss);
    case 3
        N = 4;      % 状态变量维度
        M = 3;      % 输入变量维度 = 输出变量维度
        sys_ss = rss(N,M,M) ;

        A = sys_ss.A;
        B = sys_ss.B;
        C = sys_ss.C;
        sys_ss.D = zeros(size(sys_ss.D));

        sys_tf = tf(sys_ss);
end

%% ====== 前馈补偿器解耦 ======
sys_decoupler_tf = inv(sys_tf);
order(sys_decoupler_tf)
sys_decoupler_ss = ss(sys_decoupler_tf);
% 系统应接近单位矩阵 sys_identity_tf = tf(eye(M))
sys_identity_tf = sys_tf*sys_decoupler_tf;
% 系统应接近单位矩阵 sys_identity_ss = ss(tf(eye(M))) = ss(eye(M))
sys_identity_ss = ss(sys_identity_tf );

% ---- check -----
% Verify decoupling (should show diagonal dominance)
error_D_to_identity = max(abs(sys_identity_ss.D - eye(M)),[],'all')
error_C_to_zero = max(abs(sys_identity_ss.C - 0 ),[],'all')

if showApp, linearSystemAnalyzer('bodemag',sys_identity_tf), end

%% ====== 状态反馈解耦 ======
Co = ctrb(A,B);
a=reshape( C*Co,M,M,[] );
b=squeeze( any(abs(a)>eps,2) );
[val_1, integrator_orders ]=max(b,[],2);
assert(all(val_1),'算不出d,不能解耦?')

% 状态反馈解耦中的4个特征量
% integrator_orders 是状态反馈解耦后传递函数阵(积分型解耦系统)中对角线上积分器的阶数
d_A_power = integrator_orders -1;
D_m = [];
for k = 1:M
    D_m = [ D_m ;C(k,:)*A^d_A_power(k)];
end
E = D_m*B;
L = D_m*A;
assert(abs(det(E))>eps,'E 矩阵奇异,不能解耦')

% 积分型解耦系统
F = inv(E);
K = F*L;
sys_A = ss(A,eye(N),eye(N),zeros(N));
sys_WKF = C * feedback( sys_A*B ,K) * F;
sys_WKF_tf = tf(sys_WKF);

if showApp, linearSystemAnalyzer('bodemag', sys_WKF_tf ), end

sys_reduce = tf( ...
    cellfun(@(arr) round(arr,10),sys_WKF_tf.Numerator,'UniformOutput',false),...
    cellfun(@(arr) round(arr,10),sys_WKF_tf.Denominator,'UniformOutput',false)...
    );
minreal(sys_reduce)
return

%%
% ---------------
temp_num = sys_tf;

denominator_coeffs  = cell2mat(reshape(temp_num.Denominator,[],1));
expect_value_1 = size(unique(denominator_coeffs ,'rows'),1)
temp_denum_reciprocal = tf(mean(denominator_coeffs ),1);
temp_num.Denominator = repmat({[1]}, M, M);
% sys_tf = temp_num / temp_denum_reciprocal
order(sys_tf)
order(temp_num / temp_denum_reciprocal)
% ---------------
temp_inv_num=inv(temp_num);

denominator_coeffs  = cell2mat(reshape(temp_inv_num.Denominator,[],1));
expect_value_1 = size(unique(denominator_coeffs ,'rows'),1)
temp_inv_denum = tf(1,mean(denominator_coeffs ));
temp_inv_num.Denominator = repmat({[1]}, M, M);
% inv(temp_num) = temp_inv_num * temp_inv_denum
order(inv(temp_num))
order(temp_inv_num * temp_inv_denum)
% ---------------
% inv(sys_tf) = temp_denum_reciprocal*inv(temp_num)
%             = temp_denum_reciprocal * temp_inv_num * temp_inv_denum
sys_tf_inv = temp_denum_reciprocal * temp_inv_num * temp_inv_denum;
order(inv(sys_tf))
order(sys_tf_inv)
% -----------------
% sys_tf*inv(sys_tf) = sys_tf * sys_tf_inv
%            = temp_num  * temp_inv_num * temp_inv_denum
%            = Identity
order(sys_tf*inv(sys_tf))
order(sys_tf * sys_tf_inv)
order(temp_num  * temp_inv_num * temp_inv_denum)

sys_identity_tf_1 = sys_tf * sys_tf_inv;
sys_identity_ss_1 = ss(sys_identity_tf_1,'min');
order(sys_identity_tf_1)
order(sys_identity_ss_1)

sys_identity_tf_2 = temp_num  * temp_inv_num * temp_inv_denum;
sys_identity_ss_2 = ss(sys_identity_tf_2,'min');
order(sys_identity_tf_2)
order(sys_identity_ss_2)

%%
sys = sys_identity_tf_1;
sys_reduce = tf( ...
    cellfun(@(arr) round(arr,5),sys.Numerator,'UniformOutput',false),...
    cellfun(@(arr) round(arr,5),sys.Denominator,'UniformOutput',false)...
    );

minreal(sys_reduce)

% linearSystemAnalyzer('bodemag', sys_identity_tf_1 )
% linearSystemAnalyzer('bodemag', sys_identity_tf_2 )






