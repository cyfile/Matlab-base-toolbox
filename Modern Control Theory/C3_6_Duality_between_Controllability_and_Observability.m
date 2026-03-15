% 3.6 能控性与能观性的对偶关系

clc,clear
%
p = 3 ; % outputs 
m = 2 ; % inputs
n = 4 ; % states
sys = rss(n,p,m);
if rand>.5
    sys.D = zeros(p,m);
end

[A,B,C,D] = ssdata(sys);
sysD = ss(A',C',B',D');

% -------- 对偶系统的传递函数阵是互为转置的
sys_tf = tf(sys);
sysD_tf = tf(sysD);
% H = ctranspose(G) computes the conjugate of the dynamic system model G. 
% The ctranpose command is equivalent to the ' operator.
% sys_tf != sysD_tf'
% sys_tf == sysD_tf.'
s = minreal(sys_tf-sysD_tf.',1);
[~,~,k] = zpkdata(sys_tf-sysD_tf.')
% linearSystemAnalyzer(sys_tf-sysT_tf.')

% -------- 对偶系统的特征方程是相同的
sum_error = sum(abs(poly(A)-poly(A')));
max_column_error = norm(poly(A)-poly(A'),1)
sum_error = sum(abs( pole(sys) - pole(sysD) ))
[pole(sys) , pole(sysD) , roots(poly(A)) , eig(A') ]

% -------- 对偶
ctrb(sys) - obsv(sysD)'

ctrb(sysD) - obsv(sys)'
