% 标杆所在的纬度角：
n=deg2rad( dms2degrees([39 54 26]) );
% 标杆所在的经度角：
e=deg2rad( dms2degrees([116 23 29]) );
% 太阳直射点纬度(日期)：
N_datenum=datenum([2015,10,22]);
% 太阳直射点绝对经度角向量：
time=(9:0.25:15)-8;%格林尼治时间 G.M.T.
Et_absolute=2*pi*(12-time')/24;
%%
shadow_vec=polesun2shadow(n,e,N_datenum,Et_absolute);
subplot(211)
plot(3*sqrt(sum(shadow_vec.*shadow_vec,2)))
subplot(212)
plot(shadow_vec(:,1),shadow_vec(:,2))
%%
shadow_vec4=polesun2shadow_4(n,e,N_datenum,Et_absolute,time);
subplot(211)
hold on
plot(3*sqrt(sum(shadow_vec4.*shadow_vec4,2)),'sr')
subplot(212)
hold on
plot(shadow_vec4(:,1),shadow_vec4(:,2),'sr')
return
%%
shadow_vec2=polesun2shadow_2(n,e,N_datenum,Et_absolute);
hold on;plot(3*sqrt(sum(shadow_vec2.*shadow_vec2,2)),'o')
shadow_vec3=polesun2shadow_3(n,e,N_datenum,Et_absolute);
hold on;plot(3*sqrt(sum(shadow_vec3.*shadow_vec3,2)),'*')
any(shadow_vec-shadow_vec3>1e-10)