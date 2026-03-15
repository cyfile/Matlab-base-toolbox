% 5.1 线性反馈控制系统的基本结构及其特性

% 本脚本演示线性反馈控制系统的三种基本结构：状态反馈、输出反馈及动态反馈
% 通过随机生成系统矩阵验证不同反馈控制策略的数学一致性

clear,clc;
%% ====== 系统参数配置 ======
N = 5;      % 状态变量维度
M = 2;      % 输入变量维度
A = rand(N);       % 状态转移矩阵（随机生成）
B = rand(N, M);    % 输入矩阵（随机生成）
C = rand(M, N);    % 输出矩阵（随机生成）
D = zeros(M, M);   % 直接传递矩阵（设为零矩阵）

% 原始系统构建
originalSystem = ss(A,B,C,D);

%% ====== 子系统模块化构建 ======
% 构建子系统
sys_B = ss(zeros(0),zeros(0,M),zeros(N,0),B);
size(sys_B)
sys_A = ss(A,eye(N),eye(N),zeros(N));
sys_C = ss(zeros(0),zeros(0,N),zeros(M,0),C);

sys_orig = sys_C*sys_A*sys_B;
sys_orig2 = C*sys_A*B; % 矩阵乘法验证等效性
% 原始系统串联验证
matrixError = norm(sys_orig.A - originalSystem.A)

%% ====== 状态反馈（State Feedback） ======
% 生成随机状态反馈增益矩阵（M×N）
K = rand(M,N);
% 构建状态反馈控制系统
sys_state_feed = sys_C*feedback(sys_A*sys_B,-K);
% 验证反馈后系统矩阵
[a,~,~,~] = ssdata(sys_state_feed);
matrixError = norm(A+B*K - a)

%% ====== 输出反馈（Output Feedback） ======
% 生成随机输出反馈增益矩阵（M×M）
H = rand(M,M);
% 构建输出反馈控制系统
sys_output_feed = feedback(sys_orig,-H);
% 验证反馈后系统矩阵
matrixError = norm(A+B*H*C - sys_output_feed.A)

%% ====== 输出到状态导数的反馈 （Output to State Derivative） ======
% 闭环系统: dx/dt = (A - G*C)x + Bu
%                 = A*x + B*u + G*(C*x)

% 生成随机动态补偿器增益矩阵（N×M）
G = rand(N,M);
sys_output_feed_2derivative =  feedback(sys_C*sys_A,-G)*sys_B;
% 验证反馈后系统矩阵
matrixError = norm(A+G*C - sys_output_feed_2derivative.A)

%% ====== 动态补偿器 ======
% 上面的反馈阵都是常数矩阵
% 构建K H G的系统只需 ss([],[],[],HKG)
% 如果构建的系统为 ss(A,B,C,D),其中 length(A)>0
% 则构建的是动态补偿器
% 动态补偿器可以串联连入系统,也可以通过反馈连入系统














