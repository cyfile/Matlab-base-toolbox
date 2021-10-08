% 本脚本通过符号数学工具箱展示标杆投影计算原理
syms t N n real
% 杆向向量：
pole=[cos(n) 0 sin(n)]';
% 日向向量：(地球坐标系下)
sun=[cos(N)*cos(t) cos(N)*sin(t) sin(N)]';
% 北向向量：
north=[-sin(n) 0 cos(n)]';
% 东向向量：
east=[0 1 0]';
% 影向向量：
shadow=pole-sun/(sun'*pole);
% x:
xt=east'*shadow;
pretty(simplify(xt));
yt=north'*shadow;
pretty(simplify(yt));
%%
X(t) = -cos(N)*sin(t)/(cos(n)*cos(N)*cos(t)+sin(n)*sin(N));
pretty(X(t))
Y(t)=(sin(n)*cos(N)*cos(t)-cos(n)*sin(N))/(cos(n)*cos(N)*cos(t)+sin(n)*sin(N));
pretty(Y(t))
%%
dY_X(t)=simplify(diff(Y)/diff(X));

pretty(dY_X(t))

ddY_X(t)=simplify(diff(dY_X(t)));
pretty(ddY_X(t))

% 令 ddY_X(t) 等零可以看出:
% 一般情况下，投影曲线相对立杆是外凸的
% 当取合适的n(杆所在纬度)，和N(太阳直射点纬度)时，在合适的时间
% 投影曲线的凸凹性会发生改变
