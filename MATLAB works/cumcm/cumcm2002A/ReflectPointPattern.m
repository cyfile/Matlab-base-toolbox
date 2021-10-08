clear,clc
%% 通过模拟 优化出光源长度
L=5;
N=10000000;
%N=10000000;
%%
% f=@(y,z) (y.*y+z.*z)/2/p;
p=36*36/21.6/2;
c=p/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

Cind=1;Bind=1;
Cm=nan(1e3,2);Bm=nan(1e3,2);

for n=1:N
    %% 随机光点
    x0=c;y0=rand*2*L-L;z0=0;
    %% 随机方向
    tmp_theta=pi*rand;    tmp_phi=2*pi*rand;
    vx=sin(tmp_theta)*cos(tmp_phi);
    vy=sin(tmp_theta)*sin(tmp_phi);
    vz=cos(tmp_theta);
    %% 镜面上的点
    k = (30*vx + (900*vx^2 - 60*vx*vy*y0 + 900*vy^2 - vz^2*y0^2 + ...
        900*vz^2)^(1/2) - vy*y0)/(vy^2 + vz^2);
    xp=x0+k*vx;yp=y0+k*vy;zp=z0+k*vz;
    %
    %     60*xp-yp*yp-zp*zp
    %     if (60*xp-yp*yp-zp*zp)>0.0001 , error('error') , end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    if xp<=21.6
        
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
        if z < 0.01e3
            if y>2.59e3 && y<2.61e3
                Cm(Cind,:)=[yp,zp];
                Cind =Cind +1;
            end
            if y>1.29e3 && y<1.31e3
                Bm(Bind,:)=[yp,zp];
                Bind =Bind +1;
            end
        end
        
    end
    
end
Cm(Cind:end,:)=[];Bm(Bind:end,:)=[];
%%
plot(Cm(:,1),Cm(:,2),'+')
hold on
plot(Bm(:,1),Bm(:,2),'r+')
title('可以确定 -2<y<2 -2<z<2 的区间')


