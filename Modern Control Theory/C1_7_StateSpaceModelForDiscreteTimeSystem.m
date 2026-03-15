% 1.7 离散时间系统的状态空间表达式
%
% x(k+1) = G * x(k) + H * u(k)
% y(k)  = C * x(k) + D * u(k)

N =4;
P =3;
M = 2;
ts = 0.1;
sys = drss(N,P,M)
sys.A
try
    sys.G
catch e
    disp(e.message)
end
get(sys)
step(sys)
%
sys_zpk = zpk(sys)
sys_zpk.ts=0.5;
figure
step(sys_zpk)