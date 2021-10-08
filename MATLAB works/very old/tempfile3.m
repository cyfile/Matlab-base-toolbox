%% pi!=pi
clear
sin(pi)%计算机内部(双精度浮点等数据类型)无法准确表示pi
a=sym(pi); %
% 这是将计算机存储的pi的数值 转化为符号变量a
% 但是转化过程是有误差的(因为要尽量使用整数算式表示)
% 所以得到了准确的pi
% Floating-point numbers obtained by evaluating expressions of the form 
% p/q, p*pi/q, sqrt(p), 2^q, and 10^q for modest sized integers p and q 
% are converted to the corresponding symbolic form. 
% This effectively compensates for the round-off error 
% involved in the original evaluation, 
% but might not represent the floating-point value precisely.
sin(a)
clear
syms pi %相当于 pi=sym(pi)
sin(pi)
%% ============================================
%% 所有矩阵在matlab看来都是可以对角化的
A = [3 1 0; 0 3 1; 0 0 3];
[V,D] = eig(A)
rank(A-D)
% Since MATLAB performs the decomposition using floating-point computation
% matlab 还是找到了三个特征向量
V*D-A*V
rank(V),cond(V)
%实际上matlab给出的V是满秩的,但是矩阵太病态cond(V),rank算不出来
% 要准确分解也只能用符号数学工具箱的函数
[V,J] = jordan(A)