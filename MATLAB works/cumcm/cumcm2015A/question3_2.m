%------------- 准备数据 --------------------
xy=[1.1637	3.336;
    1.2212	3.3299;
    1.2791	3.3242;
    1.3373	3.3188;
    1.396	3.3137;
    1.4552	3.3091;
    1.5148	3.3048;
    1.575	3.3007;
    1.6357	3.2971;
    1.697	3.2937;
    1.7589	3.2907;
    1.8215	3.2881;
    1.8848	3.2859;
    1.9488	3.284;
    2.0136	3.2824;
    2.0792	3.2813;
    2.1457	3.2805;
    2.2131	3.2801;
    2.2815	3.2801;
    2.3508	3.2804;
    2.4213	3.2812];
hold on
plot(xy(:,1),xy(:,2)),plot(0,0,'x'),plot(xy(:,1),xy(:,2),'x')
axis equal
%%
% 太阳直射点绝对经度角向量：
time=(13+9/60:3/60:14+9/60)-8;%格林尼治时间 G.M.T.
Et_absolute=2*pi*(12-time')/24;%太阳直射点的经度转弧度
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------配置坐标计算和误差衡量函数------------------------
%%
global calobjval calcoord
calcoord = 4;
%%
% 优化时 使用第一种目标计算方法
%calobjval= 1;  %目标函数的第一种计算方法
%|||||||||||||||||||||||||||||||||||||||
% 优化时 使用第二种目标计算方法(需要图像处理工具箱）
calobjval= 2;  %目标函数的第二种计算方法
% 这种方法较精确但是会遇到更多的局部极小值点
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------- 优化 ------------------------
%%
x0=[0;0;datenum([2015,6,22,0,37,0])];
lb=[-pi/2;-pi;datenum([2015,1,1,0,0,0])];
ub=[pi/2;pi;datenum([2015,12,31,24,0,0])];

problem = createOptimProblem('fmincon', ...
    'objective', @(x) objfun(x(1),x(2),x(3),Et_absolute,xy,time), ...
    'x0',x0, 'lb',lb, 'ub',ub);

gs = GlobalSearch;
ms = MultiStart;
tic
[x,fval,exitflag,output,solutions]= run(ms,problem,15);
toc
%%
disp('日期为以下四个日期之一: ')
day_interval=x(3)-datenum([2015,6,21,0,0,0]);
disp( datevec( [  datenum([2015,6,21,0,0,0])+day_interval ; ...
    datenum([2015,6,21,0,0,0])-day_interval ; ...
    datenum([2015,12,22,0,0,0])+day_interval ; ...
    datenum([2015,12,22,0,0,0])-day_interval ]))
disp('北纬n为以下两个纬度之一: ')
disp(degrees2dms( rad2deg([x(1);-x(1)]) ))%xy平面夹角弧度转北纬度分秒
disp('东经e为以下两个纬度之一: ')
disp(degrees2dms( rad2deg([x(2);pi+x(2)]) ))%xz平面夹角弧度转东经度分秒
%%
XY=polesun2shadow_4(x(1),x(2),x(3),Et_absolute,time);
%[val,Tmat,L,theta,vec]=findmat(XY,xy);
[val,Tmat,L,theta,vec]=findmat_2(XY,xy);
fval-val% 检验
XY_new=bsxfun(@plus,XY*Tmat,vec);
hold on;
plot(XY(:,1),XY(:,2),'m'),plot(0,0,'mo')
plot(XY_new(:,1),XY_new(:,2),'mo')




