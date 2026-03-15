% 1.6 从状态空间表达式求传递函数阵
%
% 本脚本实现控制系统状态空间模型到传递函数阵的转换验证，
% 并验证并联、串联、反馈三种典型连接方式的状态阵计算公式
%
clear,clc
%% ================== 系统参数配置 ==================
N = 5;      % 状态变量维度
M = 3;      % 输入变量维度 = 输出变量维度
% 随机生成系统矩阵
A = rand(N);       % 状态转移矩阵
B = rand(N, M);    % 输入矩阵
C = rand(M, N);    % 输出矩阵
D = zeros(M, M);   % 直接传递矩阵（设为零）

% 构建原始系统
sys_ss_0 = ss(A,B,C,D);
sys_tf_0 = tf(sys_ss_0);
%% ================== 符号运算求解传递函数阵 ==================
disp("  ------ C*inv(s*I-A)*B -------")
% s域中 按公式进行符号运算求解传递函数阵
s = tf('s');
% --- 1 --- 直接但结果复杂的函数阵
sys_tf_2 = C*inv(s*eye(N)-A)*B; 
sys_validation = sys_tf_0 - sys_tf_2;
sum_error = sum(abs( dcgain(sys_validation)),'all')
sum_error = sum(abs( evalfr(sys_validation,1i)),'all')

% --- 2 --- 结果稍微不那么复杂的函数阵
% 计算状态转移矩阵的逆 (sI - A)^(-1)
temp=inv(s*eye(N)-A);
denominator_coeffs  = cell2mat(reshape(temp.Denominator,[],1));
expect_value_1 = size(unique(denominator_coeffs ,'rows'),1)
% 由于用数值运算代替了符号运算,通常 expect_value_1 != 1
% 所以,手动合成系统行列式 sys_det = 1/det(sI - A)
sys_det = tf(1,mean(denominator_coeffs ));
% 手动合成伴随矩阵 sys_adjoint = adjoint(s*I-A)
sys_adjoint = temp;
sys_adjoint.Denominator = repmat({[1]}, N, N);
% 再次构建模型
sys_tf_1 = C*sys_adjoint*B*sys_det;
sys_ss_1 = minreal(ss(sys_tf_1));
% ----------- check -----------
% 验证符号计算结果与原始模型的一致性
sys_validation = sys_tf_0 - sys_tf_1;
max_numerator = max(max(cell2mat(sys_validation.Numerator)))
sys_validation = parallel(sys_ss_0,-sys_tf_1);
sys_temp = minreal(sys_validation);
sys_is_static = isstatic(sys_temp)
direct_feedthrough_Matrix = sys_temp.D



%% ============= Parallel connection  ============
disp("  ------ Parallel -------")
% 构建并联系统（两种实现方式）
sys_para = parallel(sys_ss_0,-sys_ss_1);
sys_para_1 = sys_ss_0 - sys_ss_1;
A1 = sys_ss_0.A;
A2 = sys_ss_1.A;
% ----------- check -----------
% 验证并联系统的状态转移矩阵
% 并联加减不影响A阵 ,只影响C和D
check = sys_para.A - blkdiag(sys_ss_0.A,sys_ss_1.A);
sum_error = sum(abs(check(:)))
check = sys_para_1.A - blkdiag(A1,A2);
sum_error = sum(abs(check(:)))

%% =========== Series connection  =============
disp("  ------ Series -------")
% 构建第二个随机系统
A2 = rand(N);       % 状态转移矩阵（随机生成）
B2 = rand(N, M);    % 输入矩阵（随机生成）
C2 = rand(M, N);    % 输出矩阵（随机生成）
D2 = zeros(M, M);   % 直接传递矩阵（设为零矩阵）
sys2_ss = ss(A2,B2,C2,D2);
% 构建串联系统（两种实现方式）
sys_seri = series(sys_ss_0,sys2_ss);
sys_seri_1 = sys2_ss*sys_ss_0;
% ----------- check -----------
% 验证并联系统的状态转移矩阵
% 理论公式：[A2, B2*C1; 0, A1]
A1 = sys_ss_0.A;
C1 = sys_ss_0.C;
sys_temp = minreal(sys_seri-sys_seri_1);
sys_is_static = isstatic(sys_temp)
direct_feedthrough_Matrix = sys_temp.D
check = sys_seri.A - [A2,B2*C1;zeros(N),A1];
sum_error = sum(abs(check(:)))

%% ============= Feedback connection =============
disp("  ------ Feedback -------")
% 构建第二个随机系统
A2 = rand(N);       % 状态转移矩阵
B2 = rand(N, M);    % 输入矩阵
C2 = rand(M, N);    % 输出矩阵
D2 = zeros(M, M);   % 直接传递矩阵（设为零矩阵）
sys2_ss = ss(A2,B2,C2,D2);
sys2_tf = tf(sys2_ss);
% 构建反馈连接系统
sys_ss_fb = feedback(sys_ss_0,sys2_ss);
sys_tf_fb = tf(sys_ss_fb);
% ----------- check -----------
% 验证反馈系统的状态转移矩阵
% 理论公式： [A1,-B1*C2;B2*C1,A2]
A1 = sys_ss_0.A;
B1 = sys_ss_0.B;
C1 = sys_ss_0.C;
A2 = sys2_ss.A;
B2 = sys2_ss.B;
C2 = sys2_ss.C;
check = sys_ss_fb.A - [A1,-B1*C2;B2*C1,A2];
sum_error = sum(abs(check(:)))
% ----------- check -----------
% 验证反馈系统传递函数阵符号运算公式
sys_tf_fb_1 = sys_tf_0*inv(eye(M) + sys2_tf*sys_tf_0);
sys_tf_fb_2 =          inv(eye(M) + sys_tf_0*sys2_tf)*sys_tf_0;

dcgain_validation = dcgain( sys_tf_fb_1 - sys_tf_fb_2 );
sum_error = sum(abs(dcgain_validation),'all')

[~,~,k] = zpkdata(sys_tf_fb - sys_tf_fb_1);
sum_gain = sum(abs(k),'all')
%%
linearSystemAnalyzer('bodemag',sys_tf_fb,sys_tf_fb_1)
linearSystemAnalyzer('bodemag',sys_tf_fb_2,sys_tf_fb_1)



