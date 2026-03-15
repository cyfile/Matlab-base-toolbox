% 4.2 李雅普诺夫第一法
%
% 李雅普诺夫第一法 即 Lyapunov's Indirect Method
% 对于一个一般的系统(时变非线性系统),
% 小扰动近似线性化
% 限定其感兴趣的时间点附近,通过级数展开,将其近似为一个定常线性系统
% 通过新的时不变线性系统的 状态转移矩阵的特征值,
% 间接判定原系统在平衡点处的稳定性
% 
clc,clear
%% ====== 线性系统的稳定判据 ======
% 以下讨论是针对线性定常系统,所以提到的稳定等同于大范围渐进稳定
N = 4;
P = 2; % dim of output
M = 3; % dim of input
% --- 状态稳定 仅与A 有关 ---
sys = rss(N,N,M); % rss 生成的系统都是稳定的
sys.C = eye(N); % 输出所有状态
sys.D = [];

e_A = eig(sys.A);
check_poles = [e_A,pole(sys)]
% A的所有特征根具有负实部 <=> 状态稳定
check_stable = [all(real(e_A)<0),isstable(sys)]

% --- 输出稳定 由 A b C 共同决定 ---
sys = rss(N,P,M);  % rss 生成的系统都是稳定的
rank(obsv(sys))==4  % rss 生成的系统总是最小实现的
% 即系统完全能控能观
% 所以 pole(sys) 就是 传递函数的极点
sys_tf = zpk(sys);
celldisp(sys_tf.p)
pole_sys = sys_tf.p{randi(P*M)};
check_poles = [pole_sys,pole(sys)]
% W(s) = C*inv(sI-A)*B
% 传递函数的极点位于s左半平面 <=> 输出稳定
check_stable = [all(real(pole_sys)<0),isstable(sys)]

%% ====== 状态稳定 和 输出稳定的关系 ======
% ---------------------
% 以下纯属个人猜测,请以教材为准
% 1,系统状态稳定,系统的输出一定稳定
% 2,系统状态不稳定,且不稳的状态存在于系统能观的部分,则系统的输出不稳定
% 3,系统状态不稳定,但不稳的状态存在于系统不能观的部分,则系统的输出稳定
%
% 传递函数阵仅能表示系统中能观和能控的部分
% 所以当系统中存在不能观的部分时,由状态空间模型转化为传递函数阵的时候
% 必出现零极点相消的情况,即系统会降阶
% 此时A的特征值会和系统传递函数的极点不同
% ---------------------
input_dim = 2;
output_dim = 2;
A11 = -rand(3)-11;
A22 = rand(2)+22;
A21 = rand(2,3)+21;
B1= rand(3,2)+1;
B2= rand(2,2)+2;
C1 = rand(2,3)+3;

sys_obs = ss(A11,eye(3),eye(3),[]);
sys_obs.InputName='in_A11';
sys_obs.OutputName = "out_A11";
sys_unobs = ss(A22,eye(2),eye(2),[]);
sys_unobs.InputName='in_A22';
sys_unobs.OutputName = "out_A22";
sys_A21 = ss([],[],[],A21);
sys_A21.InputName='out_A11';
sys_A21.OutputName = "in_A22_A21";
sys_B1 = ss([],[],[],B1);
sys_B1.InputName='in';
sys_B1.OutputName = "in_A11";
sys_B2 = ss([],[],[],B2);
sys_B2.InputName='in';
sys_B2.OutputName = "in_A22_B2";
sys_C1 = ss([],[],[],C1);
sys_C1.InputName='out_A11';
sys_C1.OutputName = "out";
blk_sum = sumblk('in_A22 = in_A22_B2 + in_A22_A21',2);

% specify inputs and outputs of the whole system
inputs = {'in'};          % 总系统输入端口
outputs = {'out'};         % 总系统输出端口

% connect all sub systems
opt = connectOptions(Simplify=false);
sys = connect(sys_obs, sys_unobs, sys_A21, ...
    sys_B1, sys_B2, sys_C1, blk_sum, ...
    inputs, outputs ,opt);
size(sys)

sys_tf = tf(sys);
size(sys_tf )

% --- check ---
% 1, 系统降阶了,即零极点对消了
unique(cell2mat(sys_tf.den(:)),'row')
pole(sys_tf),pole(sys)
order(sys),order(sys_tf)

assert(sys_order - sys_tf_order == rank(obsv(sys)), ...
    "总系统状态维度-不可观子空间维度=传递函数阵状态数")
% 2, 系统传递函数的极点和状态空间表示的系统中的能观子系统的极点一致

pole(sys_tf),pole(sys)
eig(sys.A)

% 3, 系统输出的稳定性应和系统能观部分的稳定性相同
assert(isstable(sys)==(istable(sys_obs) && istable(sys_unobs)),...
    '状态稳定性由能观和不能观两个子系统共同决定')
assert(isstable(sys_tf)==istable(sys_obs), ...
    '输出的稳定性应和系统能观部分的稳定性相同')

%% ---------------------
% --- 系统状态不稳,其输出可以稳定 ---
% 系统不稳的状态仅存在于系统的不可观部分,则系统的输出也会稳定
% 此时计算系统的传递函数阵时将出现零极点对消
% 此时A阵的特征值和系统传递函数的极点不同
N = 5;
P = 2; % dim of output
M = 3; % dim of input
% rss 总生成稳定(含临界稳定)的系统
sys_stable = rss(3,2,3);
sys_unstable = rss(2,2,3);
sys_unstable.A = -sys_unstable.A;
[isstable(sys_stable),isstable(sys_unstable)]

A = [sys_stable.A,zeros(3,2);rand(2,3),sys_unstable.A];
B = [sys_stable.B;sys_unstable.B];
C = [sys_stable.C,zeros(size(sys_unstable.C))];
sys_composite = ss(A, B, C, 0);
size(sys_composite)

sys = minreal(sys_composite);
size(sys)
% --- check ---
[isstable(sys_composite),isstable(sys)]
[rank(obsv(sys_composite)),order(sys)]


%% ====== 非线性系统的稳定性 ======
%  考虑非线性系统
%  dx1 = x1 - x1*x2
%  dx2 = -x2 + x1*x2
% --- 非线性系统 ---
% 准备数据
[x1,x2] = meshgrid(-3:.05:4,-2:.05:3);
dx1 = x1 - x1.*x2;
dx2 = -x2 + x1.*x2;
% 计算平衡点
xe0 = [0,0];
xe1 = [1,1];
xe = [xe0;xe1];

subplot(211)
streamslice(x1,x2,dx1,dx2);
hold on
scatter(xe(:,1),xe(:,2),[],'red',"filled")
axis tight
% --- xe0 平衡点处的线性化 ---
A0=[1,0;0,-1];
r = roots(poly(A0))
if any(r>0), disp('原非线性系统在xe0处不稳定'), end
[x1,x2] = meshgrid(-1:.05:1);
dx1 = x1;
dx2 = -x2;
subplot(223)
streamslice(x1,x2,dx1,dx2);
axis tight
% --- xe1 平衡点处的线性化 ---
A1=[0,-1;1,0];
r = eig(A1)
if any(r>0), disp('原非线性系统在xe0处不稳定'), end
if any(real(r)==0), disp('不能由该线性化方程判断原系统在xe1处的稳定性'), end
[x1,x2] = meshgrid(-1:.05:1);
dx1 = -x2;
dx2 = x1;
subplot(224)
streamslice(x1,x2,dx1,dx2);
axis tight
% matlab 的一些计算规则:
assert(all([...
    isequal(1i==0, false),...
    isequal(1i<=0, true),...
    isequal(-1i>=0, true),...
    isequal(1+1i>=0, true)]))