function shadow_vec=polesun2shadow_4(n,e,N_datenum,Et_absolute,time)
% 生成单位杆长在水平面上投影的坐标向量
% 考虑地球半径和日地距离,以及太阳直射点在一天之内的变化
%
%标杆所在点纬度角：n。北纬为正，南纬为负 取值区间：[-pi/2,pi/2]
%标杆所在点经度角：e。东经为正，西经为负 取值区间：[-pi,pi]
%太阳直射点所在点纬度角：N。北纬为正，南纬为负 取值区间：[-pi/2,pi/2]
%数值日期：N_datenum
%太阳直射点所在点经度角向量：Et_absolute。东经为正，西经为负 取值区间：[-pi,pi]
%
%
Rs_mean =149600000000;
Re_mean=6371393;%严格说还得加杆长
%% 太阳直射点的纬度角的正余弦
N_RET = deg2rad( dms2degrees( [23 26 21.448] ) ); %北回归线纬度
time_GMT=N_datenum + time'/24;
alpha=2*pi*(datenum([2015,6,21,16,37,0])-time_GMT)/365.2422;% 太阳直射点的夏至旋转角
% 通过地轴向量和日向向量(日地坐标系下)的内积确定太阳直射点的纬度角(正余弦)
%N=pi/2-acos([sin(N_RET),0,cos(N_RET)]*[cos(alpha),sin(alpha),0]');%太阳直射点的纬度角
sin_N=sin(N_RET)*cos(alpha);%=sin(N)
cos_N=sqrt(1-sin_N.^2);%=cos(N)
%% 太阳直射点经度相对杆点经度的
% 相对经度角：
Et=Et_absolute-e;
%%
% 杆向向量：[cos(n) 0 sin(n)]
% 日向向量：[cos(N)*cos(Et) cos(N)*sin(Et) sin(N)] (地球坐标系下)
% 北向向量：[-sin(n) 0 cos(n)]
% 东向向量：[0 1 0]
%% 杆向向量
PoleTop_vect_unit=[cos(n) 0 sin(n)]';
%%
shadow_vec_3D=zeros(length(Et),3);
for k=1:length(Et)
    %% 日向向量
    Sun_vect_unit=[cos_N(k)*cos(Et(k)) cos_N(k)*sin(Et(k)) sin_N(k)]';
    %% 光向向量：杆的顶点位置向量减去太阳位置向量
    % 光向向量(在不考虑地球半径和日地距离时该向量就是日向向量)
    light_vec=Re_mean*PoleTop_vect_unit-Rs_mean*Sun_vect_unit;
    %light_vec_unit=orth(light_vec);
    %theta(k)=subspace(PoleTop_vect_unit,light_vec_unit);
    %shadow_vec_3D(k,:)=PoleTop_vect_unit+light_vec_unit'/cos(theta);
    %shadow_vec_3D(k,:)=PoleTop_vect_unit+light_vec_unit'/(PoleTop_vect_unit*light_vec_unit);
    shadow_vec_3D(k,:)=PoleTop_vect_unit-light_vec/(PoleTop_vect_unit'*light_vec);
    %% 验证代码
    if 0
        shadow_vec_3D(k,:)*PoleTop_vect_unit
        if shadow_vec_3D(k,:)*PoleTop_vect_unit>1e-5
            error('error')
        end
    end
    %%
end
%% 投影的平面坐标
y_e=[-sin(n) 0 cos(n)]';%北向单位向量
x_e=[0 1 0]';%东向单位向量
A=[x_e,y_e];%坐标变换矩阵。
%% 影向向量：
% 水平面上的影向向量： (正东方为x轴，正西方为y轴)
shadow_vec=shadow_vec_3D*A;


