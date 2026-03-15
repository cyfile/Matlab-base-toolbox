% 5.5 状态观测器
%
% 通过设计 观测器 输出反馈至状态导数的 反馈矩阵 G
% 来配置观测器的极点，
% 从而确定 观测器 估计状态 渐近收敛至 原系统实际状态 的速率

clear,clc
disp('This example only demonstrates with SISO systems')
%% ====== 状态观测器的存在性 ======
% 线性定常系统状态观测器存在的充要条件是系统的不能观子系统渐进稳定
%     系统的输出仅反映系统的能观部分,
%     从系统输出无法得到不能观部分的信息
%     所以只有当不能观子系统渐进稳定的同时
%     在观测器中构造相应的渐进稳定部分
%     整个观测器的输出状态,才能渐进趋近于原系统的所有状态.
%     根据我的猜测
%     理想条件下(不可实现),如果系统的不能观子系统不稳定,
%     但观测器的不能观子系统,和原系统的不能观子系统的初始条件一样
%     那么 整个观测器的输出状态,也能渐进趋近于原系统的所有状态.

% 若系统完全能观,则状态观测器存在且能实现
%     即系统的状态矢量可由系统的输入和输出进行重构

%% ======  System generation ======
choice = randi(2);
choice = 1;
switch choice
    case 1
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
        % Generate random target poles (in practice, specify desired dynamics)
        target_poles = roots(rand(N+1,1));
        target_poles = -sign(real(target_poles)).*target_poles;
    case 2
        N = 2;
        A = [1,0;0 0];
        B = [1;1];
        C = [2,-1];
        target_poles =-[10,10]';
end

%% ====== 按照给定极点构造状态观测器 ======

% --- 通过输出到状态导数的反馈配置极点的证明过程 ---
% (1),检验系统能观性
Ob= obsv(A,C);
assert( rank(Ob) == N ,"系统不能观")
% (2),计算系统特征多项式,
%       按公式计算能观II型的变换阵,
%       得到系统能观II型 下的 A_tilde
origin_alpha = poly(A);
T_o2_inv = triu(toeplitz(origin_alpha(1:end-1)))*flipud(Ob);
A_tilde = T_o2_inv*A*inv(T_o2_inv);
A_tilde_check = ss2ss(ss(A,[],[],[]),T_o2_inv).A ; %应该和 A_tilde 一样

% (3),计算反馈后系统的特征多项式,
%       通过该多项式写出 反馈后系统 的能观II型 下的A_bar
target_alpha = poly(target_poles);
A_bar = [[zeros(1,N-1);eye(N-1)],-target_alpha(end:-1:2)'];

% (4),因为反馈到状态导数的输出反馈系统 有关系 A_bar = A_tilde - G_bar*C_oII 
%       而此时能观二型的C_oII阵仅最后一列为1,其他元素为0
%       所以 G 仅由 A_bar 和 A_tilde 最后一列之差确定
G_bar_0 = A_tilde(:,end) - A_bar(:,end);
G_bar_0 = (-origin_alpha) - (-target_alpha);
G_bar= G_bar_0(end:-1:2)';

% (5),通过步骤(2)中的原系统能观II型的变换阵,反变换G_bar
G = inv(T_o2_inv)*G_bar;

% (验算),验算
%       对于阶数低的A阵,可以直接将A,C阵带入
%       poly(A-G*C) = poly(target_poles) 求G
[roots(poly(A-G*C)),target_poles]


%% -------------------------------
% --- 计算过程 ---
% (1),检验系统能观性
Ob= obsv(A,C);
assert( rank(Ob) == N ,"系统不能观")
% (2),计算系统特征多项式
origin_alpha = poly(A);
% (3),计算反馈后系统的特征多项式
target_alpha = poly(target_poles);
% (4),计算系统能观II型的下的 反馈到状态导数的输出反馈阵 G_bar
G_bar_0 = target_alpha - origin_alpha;
G_bar= G_bar_0(end:-1:2)';
% (5),根据原系统的能观判别阵(来自步骤1)和特征多项式(来自步骤2),
%     通过公式构建能观II型的变换阵, 反变换出G
T_o2_inv = triu(toeplitz(origin_alpha(1:end-1)))*flipud(Ob);
G = inv(T_o2_inv)*G_bar;


%% ====== 建模验证构造的状态观测器及其性质 ======
% x_dot_flex_bar 

sys_AB = ss(A,B,eye(N),[]);
sys_AB.InputName='u';
sys_AB.OutputName = "x";

sys_C = ss([],[],[],C);
sys_C.InputName = 'x';
sys_C.OutputName = "y";

sys_B = ss([],[],[],B);
sys_B.InputName='u';
sys_B.OutputName = "Bu";

sys_A_flex = ss(A-G*C,eye(N),eye(N),[]);
sys_A_flex.InputName='Bu_Gy';
sys_A_flex.OutputName = "x_flex";

sys_G = ss([],[],[],G);
sys_G.InputName='y';
sys_G.OutputName = "Gy";

AP = AnalysisPoint('x',N);
% 这个地方是 +, Bu + Gy
blk_sum = sumblk('Bu_Gy = Bu + Gy', N);

%% ----------------------
% specify inputs and outputs of the whole system
input = 'u';
output = "x_flex";
APs = 'x';

% connect all sub systems
opt = connectOptions(Simplify=false);
sys_observed = connect(sys_AB, sys_C, ...
                    sys_B, sys_A_flex, sys_G, ...
                    blk_sum, ...
                    input, output ,APs); % ,opt

%% --- check ---
% 新系统的阶数为原系统的阶数加上观测器的阶数
% 新系统的极点为原系统的极点加上观测器的极点
[pole(sys_observed),[target_poles;pole(sys_AB)]]
%
rank ( obsv(sys_observed) )
rank ( ctrb(sys_observed) )


% 
getPoints(sys_observed);
sys_u2x = getIOTransfer(sys_observed,'u','x');
zpk(sys_AB - sys_u2x).k


% 用反馈阵 G 配置观测器的极点.
% 观测器的极点(target_poles)决定了,观测状态趋近原系统状态的速度.
% 此脚本前面如果随机选取的配置极点,系统多半不会稳定,
% 但即使观测器不稳,由于系统初始状态都相同(为0),
% 所以理论上即使系统不稳,状态真值与状态估值也会严格相等
sys_x_x_flex =  sys_u2x - sys_observed;
% 这个在下一节被称为 观测器反馈和直接反馈的等效性
zpk(sys_x_x_flex).k
rank ( obsv(sys_x_x_flex) )
% ??? 我的理解是sys_x_x_flex应该和输入无关,也就是完全不可控  ???
% ??? 但是这里似乎不是这样 ???
rank ( ctrb(sys_x_x_flex) )

linearSystemAnalyzer( 'impulse',sys_u2x - sys_observed )
linearSystemAnalyzer( sys_u2x - sys_observed )