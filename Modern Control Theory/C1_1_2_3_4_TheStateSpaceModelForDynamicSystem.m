% 第1章　控制系统的状态空间表达式
%
% 

clc,clear
%% ====== 状态空间表达式 ======
% C1_1 系统的状态空间表达式

% 状态变量 状态向量 状态空间 状态轨迹

% 线性定常连续系统的
% --- 状态方程 ---
% dx = A*x + B*u
% A 系统矩阵,状态阵,系数阵
% B 输入矩阵,控制矩阵
% --- 输出方程 ---
% y = C*x + D*u
% C 输出矩阵
% D 直接传递矩阵,前馈矩阵


%% ====== 系统模型的相互转化 =======
% 系统框图 <=
% 系统的模拟结构图 <=> 系统的状态空间表达式 <=> 系统传递函数 <=> 微分方程(系统机理)

% C1_2  系统的状态空间表达式 => 系统的模拟结构图 
% C1_3  系统的模拟结构图 => 系统的状态空间表达式
%       微分方程(系统机理) => 系统的状态空间表达式
% C1_4  系统传递函数 =>  系统的状态空间表达式 
%       MIMO微分方程 => 系统的模拟结构图

%% ====== 系统传递函数 => 系统的状态空间表达式  ======
N = 4 ; % model_order = 4;
sys_ss = rss(N,1,1);
sys_tf = tf(sys_ss);
alpha = sys_tf.Denominator{:};
beta = sys_tf.Numerator{:};
%% 化 sys_tf 为 能控标准I型
A_cI = [[zeros(N-1,1),eye(N-1)];-alpha(end:-1:2)];
B_cI = [zeros(N-1,1);1];
[d,bn] = deconv(beta,alpha);
C_cI = bn(end:-1:2);
D_cI = d;
sys1 = ss(A_cI,B_cI,C_cI,D_cI);
zpk(sys1-sys_tf).k
%% 化 sys_tf 为 能观标准II型
A_oII = [[zeros(1,N-1);eye(N-1)],-alpha(end:-1:2)'];
[d,bn] = deconv(beta,alpha);
B_oII = bn(end:-1:2)';
C_oII = [zeros(1,N-1),1];
D_oII = d;
sys2 = ss(A_oII,B_oII,C_oII,D_oII);
zpk(sys2-sys_tf).k