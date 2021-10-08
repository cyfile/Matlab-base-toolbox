function [c,ceq] = mycon(obj,Cy,By)
%% 优化用非线性约束函数
c=2 *sum(Cy<obj) - sum(By<obj);
ceq=[];
end