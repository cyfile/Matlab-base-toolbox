% fsolve比fzero处理更复杂的问题
Create options using the optimoptions function, or optimset for fminbnd, fminsearch, fzero, or lsqnonneg.

 

%{
题目： 矩阵A已知, 求对称阵 P (P'=P)，满足：
         A' * P+P * A = -I    (I 代表单位阵)
%}
%{
分析：n阶矩阵共有元素n^2个，其中对角线有n个元素。
     故 tril(P,-1) 有(n^2-n)/2个元素,triu(P,0) 有(n^2+n)/2个元素
     1，P是对称阵，则对于P中元素，共有至多(n^2-n)/2个线性无关的方程
     2，表达式 A'*P+P*A 在P是对称阵时也是对称阵，他等于一个对称阵，
        则对于P中元素，其产生了至多(n^2+n)/2个线性无关的方程
     综上，对于 P 中 n^2 个元素最多有 n^2 个约束，方程定有解
%}
n=4;
A=rand(n);
%%
F=@(P) [A'*P+P*A+eye(n);P-P'];
x0 =fsolve(F,rand(n))
options = optimoptions('fsolve',...
    'Display','off',...
    'Algorithm','levenberg-marquardt');%{'levenberg-marquardt',.005});
x1 =fsolve(F,rand(n),options)
%验证1，A'*x+x*A
%验证2，F(x)
%%
%A = sym(A);
p = sym('p',n);
assume(p==p');
digits(4);%计算精度不要太大，不然算不出来
x_sym = solve(A'*p+p*A+eye(n));
x2 =reshape(structfun(@double,x_sym),n,n)
%%
%%%%%%%%%%%%%%%%%%%%%%%
% 若已知 P ，求A
a=randn(4);P=a+a';
F=@(A) A'*P+P*A+eye(size(P));
x = fsolve(F,ones(size(P)));
F(x)