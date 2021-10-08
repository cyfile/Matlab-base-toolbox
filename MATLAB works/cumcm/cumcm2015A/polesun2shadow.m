function shadow_vec=polesun2shadow(n,e,N_datenum,Et_absolute)
% 生成单位杆长在水平面上投影的坐标向量(不考虑地球半径和日地距离)
%
%标杆所在点纬度角：n。北纬为正，南纬为负 取值区间：[-pi/2,pi/2]
%标杆所在点经度角：e。东经为正，西经为负 取值区间：[-pi,pi]
%太阳直射点所在点纬度角：N。北纬为正，南纬为负 取值区间：[-pi/2,pi/2]
%数值日期：N_datenum
%太阳直射点所在点经度角向量：Et_absolute。东经为正，西经为负 取值区间：[-pi,pi]
%
%
%% 太阳直射点的纬度角的正余弦
N_RET = deg2rad( dms2degrees( [23 26 21.448] ) ); %北回归线纬度
alpha=2*pi*(datenum([2015,6,21,16,37,0])-N_datenum)/365.2422;% 太阳直射点的夏至旋转角
%alpha=2*pi*(datenum([2015,6,22,0,0,0])-N_datenum)/365;% 太阳直射点的夏至旋转角
%要想获得精确结果时间的处理是很重要的，一定要使用格林尼治时间的夏至(冬至，春分，秋分)作为参考时间
%
% 通过地轴向量和日向向量(日地坐标系下)的内积确定太阳直射点的纬度角(正余弦)
%N=pi/2-acos([sin(N_RET),0,cos(N_RET)]*[cos(alpha),sin(alpha),0]');%太阳直射点的纬度角
sin_N=sin(N_RET)*cos(alpha);%=sin(N)
cos_N=sqrt(1-sin_N^2);%=cos(N)
%% 太阳直射点经度相对杆点经度的
% 相对经度角：
Et=Et_absolute-e;
%%
% 杆向向量：[cos(n) 0 sin(n)]
% 日向向量：[cos(N)*cos(Et) cos(N)*sin(Et) sin(N)] (地球坐标系下)
% 北向向量：[-sin(n) 0 cos(n)]
% 东向向量：[0 1 0]
%% 影向向量：
% 分母：
A=cos(n)*cos_N*cos(Et)+sin(n)*sin_N;
% 影向向量在北向向量上的投影：
y=(sin(n)*cos_N*cos(Et)-cos(n)*sin_N)./A;
% 影向向量在东向向量上的投影：
x=(-cos_N*sin(Et))./A;
% 水平面上的影向向量： (正东方为x轴，正西方为y轴)
shadow_vec=[x,y];


