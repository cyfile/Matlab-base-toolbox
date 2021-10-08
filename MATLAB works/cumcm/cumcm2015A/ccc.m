% 标杆所在的纬度角：
n=deg2rad( 39.52);
% 标杆所在的经度角：
e=deg2rad( 79.75  );
% 太阳直射点纬度(日期)：
N_datenum=datenum([2015,7,20]);
% 太阳直射点绝对经度角向量：
time=(12+41/60:3/60:13+41/60)-8;%格林尼治时间 G.M.T.
Et_absolute=2*pi*(12-time')/24;%太阳直射点的经度转弧度

%%
shadow_vec4=polesun2shadow_4(n,e,N_datenum,Et_absolute,time);
% subplot(211)
% hold on
% plot(3*sqrt(sum(shadow_vec4.*shadow_vec4,2)),'sr')
% subplot(212)
hold on
plot(shadow_vec4(:,1),shadow_vec4(:,2),'sr')
