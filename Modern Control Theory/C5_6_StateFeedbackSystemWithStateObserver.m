% 5.6 利用状态观测器实现状态反馈的系统
%
%

clear,clc
%% 

N = 4; % Number of states
M = 3;
P = 2;
% 随机生成受控系统
W0 = rss(N,P,M);
W0.D = 0;
A=W0.A;
B=W0.B;
C=W0.C;

% 观测器反馈阵
G = rand(N,P);
% 受控系统状态反馈阵
K = rand(M,N);

% 生成利用状态观测器进行状态反馈的系统
A_com = [A,B*K;G*C,A-G*C+B*K];
B_com = [B;B];
C_com = [C,zeros(P,N)];
sys_composite = ss(A_com,B_com,C_com,[]);

%% ====== 真实状态反馈和观测器反馈的性质 ======
% --- 闭环极点设计的分离性 ---
% 受控系统的状态反馈阵K 和 观测器的反馈阵G 可以分开设计
A_bar = [A+B*K,-B*K;zeros(N),A-G*C];
T = [eye(N),zeros(N);eye(N),-eye(N)];
sys_check = ss2ss(sys_composite,T);
norm(inv(T)*A_com*T - A_bar,1)
norm(sys_check.A - A_bar,1)
% 非奇异变换T,不改变原系统
% 但将系统的状态阵由A变为A_bar
% A_bar中K阵和G阵在对角线的两块分块矩阵中,不相互干扰
% 故 受控系统的状态反馈阵K 和 观测器的反馈阵G 可以分开设计

% --- 状态直接反馈系统 和 利用观测器反馈的系统 系统相同 ---
sys_check = tf(sys_composite) - tf(ss(A+B*K,B,C,[]));
zpk(sys_check).k

% --- 观测器反馈和直接反馈的等效性 ---
% 见上一个实验最后一部分
% 实际情况由于两个系统初始状态不同,
% 所以只有t为无穷时,反馈才等效
% G的选择决定状态趋近的速度,可以使反馈尽快趋于等效

% --- 总结 ---
% 1,G,K可以分开设计.
% 2,系统相同
% 3,永远不等效,G的设计可以使其尽量等效
% -,有没有一个时刻两者的状态碰巧相同,理论上接下来是不是就一直等效了?

%% ====== 用补偿器可以完全替代带观测器的反馈系统 ======
W_G1 = ss(A-G*C+B*K,B,K,eye(M));
W_G2 = ss(A-G*C,G ,K,[]);
W = feedback(W0 * W_G1 , -W_G2);
sys_check = sys_composite - W;
zpk(sys_check).k
