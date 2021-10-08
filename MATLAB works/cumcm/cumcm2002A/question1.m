%% 通过模拟 优化出光源长度
L=5;
N=10000000;
%%
% f=@(y,z) (y.*y+z.*z)/2/p;
% p=36*36/21.6/2;
% c=p/2;
c=15;
x0=c;
z0=0;
% Ymax=32189315698726166250/76222423330316966443;=0.4223
% Ymax=64378631397452332500/76222423330316966443;=0.8446
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
ind=1;Cind=1;Bind=1;
Py=nan(N/10,1);Pz=nan(N/10,1);
Cy=nan(1e3,1);By=nan(1e3,1);

for n=1:N
    %% 随机光点
    y0=rand*2*L-L;
    %% 随机方向
    tmp_theta=2*pi*rand;
    vz=2*rand-1;
    vx=sqrt(1-vz^2)*cos(tmp_theta);vy=sqrt(1-vz^2)*sin(tmp_theta);
    %% 镜面上的点
    k = (30*vx + (900*vx^2 - 60*vx*vy*y0 + 900*vy^2 - vz^2*y0^2 + ...
        900*vz^2)^(1/2) - vy*y0)/(vy^2 + vz^2);
    xp=x0+k*vx;yp=y0+k*vy;zp=z0+k*vz;
    %
    %     60*xp-yp*yp-zp*zp
    %     if (60*xp-yp*yp-zp*zp)>0.0001 , error('error') , end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% 通过镜面反射达到考察点
    if xp<=21.6  && ( yp < 2 && yp > -2 || zp < 2 && zp > -2)
        %     if xp<=21.6  && ( yp < 2 && yp > -2 )
        %% 该点的法向量
        nvx=30;
        nvy=-yp;
        nvz=-zp;
        %% 反射光线向量
        tmp_a=2*(vx*nvx+vy*nvy+vz*nvz)/(nvx*nvx+nvy*nvy+nvz*nvz);
        vx=vx-tmp_a*nvx;
        vy=vy-tmp_a*nvy;
        vz=vz-tmp_a*nvz;
        %%
        m=(25000+c-xp)/vx;
        y=abs(yp+m*vy);z=abs(zp+m*vz);
        if y < 3e3
            Pz(ind) = z; Py(ind) = y;
            ind = ind +1;
        end
        if z < 0.01e3
            if y>2.59e3 && y<2.61e3
                Cy(Cind)=abs(y0);
                Cind =Cind +1;
            end
            if y>1.29e3 && y<1.31e3
                By(Bind)=abs(y0);
                Bind =Bind +1;
            end
        end
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% 通过直射达到考察点
    %直射落入考察点周围的概率小于 4*0.02*0.02/(4*pi*25e3*25e3)=2e-13
    % 太小了根本捕捉不到这样的光线
    % %     if xp>21.6 && vz < 2*10/25e3 && vz > -2*10/25e3
    % %         m=(25000+c-x0)/vx;
    % %         y=abs(y0+m*vy);z=abs(z0+m*vz);
    % %         if z < 0.01e3
    % %             if y>2.59e3 && y<2.61e3
    % %                 Cy(Cind)=abs(y0);
    % %                 Cind =Cind +1;
    % %             end
    % %             if y>1.29e3 && y<1.31e3
    % %                 By(Bind)=abs(y0);
    % %                 Bind =Bind +1;
    % %             end
    % %         end
    % %     end
end
Cy(Cind:end)=[];By(Bind:end)=[];
Py(ind:end)=[];Pz(ind:end)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 优化
% max: sum(Cy<x_obj)/x_obj*L
% sum(By<x_obj)/x_obj*L  > 2 *sum(Cy<x_obj)/x_obj*L
[x_obj,fval,exitflag] = patternsearch(@(obj) -sum(Cy<obj)/obj*L,...
    3,[],[],[],[],...
    1.5,3.5,@(obj) mycon(obj,Cy,By),...
    psoptimset('Display','off'))
% x_obj 在 2.0 左右

%% 统计 C,B 两点附近的光线数
subplot(211)
plot(Cy,'*')
hold on
plot(By,'r*')

%% 画图
edges{1}=linspace(0,1.5e3,151);
edges{2}=linspace(0,3e3,301);

m=hist3([Pz Py],'Edges',edges);
%max(m(:))
M=[m(end:-1:1,end:-1:1),m(end:-1:1,:);m(:,end:-1:1),m];
subplot(212)
imshow(M,[])



