% 演示第二种目标函数带来的多极值点问题
%%
xy=[1.0365	0.4973;
1.0699	0.5029;
1.1038	0.5085;
1.1383	0.5142;
1.1732	0.5198;
1.2087	0.5255;
1.2448	0.5311;
1.2815	0.5368
1.3189	0.5426;
1.3568	0.5483;
1.3955	0.5541;
1.4349	0.5598;
1.4751	0.5657;
1.516	0.5715;
1.5577	0.5774;
1.6003	0.5833;
1.6438	0.5892;
1.6882	0.5952;
1.7337	0.6013;
1.7801	0.6074;
1.8277	0.6135];
%%
% 太阳直射点纬度(日期)：
N_datenum=datenum([2015,4,18]);
% 太阳直射点绝对经度角向量：
time=(14+42/60:3/60:15+42/60)-8;%格林尼治时间 G.M.T.
Et_absolute=2*pi*(12-time')/24;%太阳直射点的经度转弧度
%%
% % plotobjective(@(x) objfun(x(1),x(2),N_datenum,Et_absolute,xy),...
% %     [0 pi/2;0 pi])
% % return
%%
[n,e] = meshgrid(0:.05:pi/2,0:0.05:pi);
[n,e] = meshgrid(0.1:.01:1,1.5:0.01:2.5);
c=zeros(size(n));
%%
for m=1:numel(c)
    XY=polesun2shadow_4(n(m),e(m),N_datenum,Et_absolute,time);
    [val,Tmat,L,theta,vec]=findmat(XY,xy);
    c(m)=val;
%     tform = fitgeotrans([0,0;XY],[0,0;xy],'NonreflectiveSimilarity');
%     
%     %L=hypot(tform.T(1),tform.T(2));
%     new=[0,0,1;XY,ones(21,1)]*tform.T;
%     dif=new(:,1:2)-[0,0;xy];
%     c(m)=log(sum(sum(dif.*dif,2)));
end
mesh(e,n,log(c))%该函数有很多局部极值点
return
%%
for m=1:numel(c)
    XY=polesun2shadow_4(n(m),e(m),N_datenum,Et_absolute,time);
    [val,Tmat,L,theta,vec]=findmat_2(XY,xy);
    c(m)=val;
%     tform = fitgeotrans([0,0;XY],[0,0;xy],'NonreflectiveSimilarity');
%     
%     %L=hypot(tform.T(1),tform.T(2));
%     new=[0,0,1;XY,ones(21,1)]*tform.T;
%     dif=new(:,1:2)-[0,0;xy];
%     c(m)=log(sum(sum(dif.*dif,2)));
end
mesh(e,n,c)%该函数有很多局部极值点
%%
return
surf(e,n,c)
%%

view(2)
figure(gcf)
hold on
[x,fval,exitflag,output] = fmincon(@(x) objfun(x(1),x(2),N_datenum,Et_absolute,xy),...
    x0,[],[],[],[],[-pi/2;-pi],[pi/2;pi]);
x
pi*109/180
pi*18.3/180