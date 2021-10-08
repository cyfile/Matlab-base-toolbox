%------------- 准备数据 --------------------
xy=[-1.2352	0.173;
    -1.2081	0.189;
    -1.1813	0.2048;
    -1.1546	0.2203;
    -1.1281	0.2356;
    -1.1018	0.2505;
    -1.0756	0.2653;
    -1.0496	0.2798;
    -1.0237	0.294;
    -0.998	0.308;
    -0.9724	0.3218;
    -0.947	0.3354;
    -0.9217	0.3488;
    -0.8965	0.3619;
    -0.8714	0.3748;
    -0.8464	0.3876;
    -0.8215	0.4001;
    -0.7967	0.4124;
    -0.7719	0.4246;
    -0.7473	0.4366;
    -0.7227	0.4484];
hold on
plot(xy(:,1),xy(:,2)),plot(0,0,'x'),plot(xy(:,1),xy(:,2),'x')
axis equal
%%
% 太阳直射点绝对经度角向量：
time=(12+41/60:3/60:13+41/60)-8;%格林尼治时间 G.M.T.
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
switch 2
    %%
    case 1 % 仅采用局部优化的办法进行优化
        x0=[0;0;datenum([2015,6,22,0,37,0])];
        lb=[-pi/2;-pi;datenum([2015,6,22,0,0,0])];
        ub=[pi/2;pi;datenum([2015,9,23,0,0,0])];
        [x,fval,exitflag,output] = fmincon(@(x) objfun(x(1),x(2),x(3),Et_absolute,xy,time),...
            x0,[],[],[],[],lb,ub);
        %
        disp('日期: ')
        disp(datevec(x(3)))%日期
        disp('北纬n: ')
        disp(degrees2dms( rad2deg(x(1)) ))%xy平面夹角弧度转北纬度分秒
        disp('东经e: ')
        disp(degrees2dms( rad2deg(x(2)) ))%xz平面夹角弧度转东经度分秒
        %%
    case 2 % 全局优化
        x0=[0;0;datenum([2015,6,22,0,37,0])];
        lb=[-pi/2;-pi;datenum([2015,1,1,0,0,0])];
        ub=[pi/2;pi;datenum([2015,12,31,0,0,0])];
        
        problem = createOptimProblem('fmincon', ...
            'objective', @(x) objfun(x(1),x(2),x(3),Et_absolute,xy,time), ...
            'x0',x0, 'lb',lb, 'ub',ub);
        %[x,fval,exitflag,output]=fmincon(problem);
        
        gs = GlobalSearch;
        tic
        [x,fval,exitflag,output,solutions]= run(gs,problem);
        toc
        %%
        disp('日期为以下四个日期之一: ')
        day_interval=datenum([2015,6,21,0,0,0])-x(3);
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
end
return
%理论上
%在 考虑太阳直射点纬度在一天内的变化 与 不允许杆的投影镜像相似 的情况下
%只有一个时间一个杆的经纬度满足给出的投影坐标
%在 认为太阳直射点纬度在一天内不变 与 不允许杆的投影镜像相似 的情况下
%有两个时间一个杆的经纬度满足给出的投影坐标
%在 考虑太阳直射点纬度在一天内的变化 与 允许杆的投影镜像相似 的情况下
%有两个时间 每个时间下有一个杆的经纬度满足给出的投影坐标
% 严格来说仍然是只有一个时间一个杆的经纬度满足给出的投影坐标
%在 认为太阳直射点纬度在一天内不变  与 允许杆的投影镜像相似 的情况下
%有两个杆的经纬度，每个地点(杆的经纬度)有两个时间满足给出的投影坐标
%%%%%%
% 综上，不管优化至哪一点，这些点的经度都是一样的
% 所以在第一次优化后，可以将经度带入初始点，接着进行优化。
x(1),x(2)
day_interval=datenum([2015,6,21,0,0,0])-x(3);
datevec(datenum([2015,6,21,0,0,0])+day_interval)
datevec(datenum([2015,6,21,0,0,0])-day_interval)

-x(1),x(2)
datevec(datenum([2015,12,22,0,0,0])+day_interval)
datevec(datenum([2015,12,22,0,0,0])-day_interval)
return
a=cell2mat({solutions.X});
disp( datevec( a(3,:) ) )
disp(degrees2dms( rad2deg( a(1,:)' ) ))

disp(degrees2dms( rad2deg( a(2,:)') ))
