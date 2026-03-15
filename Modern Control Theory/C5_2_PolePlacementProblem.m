% 5.2 极点配置问题
%
% This script demonstrates state feedback design using pole placement
% for a random continuous-time SISO system
%
clear,clc
disp('This example only demonstrates with SISO systems')
%% ======  System Initialization ======
% System dimensions
N = 4; % Number of states
M = 1;
P = 1;
% Create random continuous-time state-space model
sys = rss(N,1,1);
sys.D = 0;
% Extract state matrices
A=sys.A;
B=sys.B;
C=sys.C;

sys_ss = sys;
sys_tf = tf(sys_ss);
% Create modified system with identity output matrix
% (for full state feedback)
sys0_AB = sys;
sys0_AB.C = eye(N);

% Generate random target poles (in practice, specify desired dynamics)
target_poles = roots(rand(N+1,1));

%% ====== Pole Placement Design ======
an = sys_tf.den{1};
bn = sys_tf.num{1};
% 能控I型 对应的状态空间的各个参数矩阵
A_ = [zeros(N-1,1),eye(N-1); -fliplr(an(2:end))]
b_ = [zeros(N-1,1);1]
c_ = bn(end:-1:2)
Co = ctrb(sys_ss);
% Controllability canonical form transformation matrix
% 因为 能控I型 = ss2ss(sys_ss,inv(T_c1))
% 所以 T_c1 可由 A,b,c 和 A_,b_,c_ 计算得出
% 下面用的是第二种方法,直接采用公式计算
T_c1 = fliplr(Co)*tril(toeplitz(an(1:end-1)));

% Create Controllability canonical form system
% with identity output matrix for full state feedback
sys0_AB_ = ss(A_,b_,eye(N),0);

% --- check ---
% Verify system equivalence with original system
[~,~,check_gain] = zpkdata(c_ * sys0_AB_ - C * sys0_AB)
assert(check_gain<1e-5,'系统不同')

% Manual feedback gain calculation
polyDifference  = an-poly(target_poles);
k_ = - polyDifference (end:-1:2);

% Construct manual feedback system
% 状态反馈
sys_state_feed_ = c_*feedback(sys0_AB_,k_);
sys_zpk = zpk(sys_state_feed_);
% Compare achieved poles with targets
Manual_Method_Poles_vs_Target = [sys_zpk.p{:},target_poles]

%% ====== MATLAB Built-in Pole Placement ======
% Use place() function for robust pole placement
K = place(A,B,target_poles);
%Compare FeedbackGain
Matlab_Method_FeedbackGain_vs_Manual=[K;k_*inv(T_c1)]

% 构建状态反馈反馈系统 
sys_state_feed = C*feedback(sys0_AB,K);
sys_zpk = zpk(sys_state_feed);
% Compare achieved poles with targets
Matlab_Method_Poles_vs_Target = [sys_zpk.p{:},target_poles]

%% ====== 输出到状态导数的反馈 ======
% 设计状态导数反馈增益（输出反馈形式）
K_output2dx = place(A', C', target_poles)';

% 构建输出到状态导数的反馈系统
sys0_AC = sys;
sys0_AC.B = eye(N);
sys_output2dx_feed =  feedback(sys0_AC,K_output2dx)*B;
sys_zpk = zpk(sys_output2dx_feed);
% Compare achieved poles with targets
Output2dx_Poles_vs_Target = [sys_zpk.p{:},target_poles]


