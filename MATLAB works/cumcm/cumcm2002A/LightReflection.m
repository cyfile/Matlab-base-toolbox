%% 反射光线的计算原理(画图)
L=5;
N=6;%N束光线
%%%%%%%%%%%%%%%%%%%
%% 抛物线
p=36*36/21.6/2;
c=p/2;
f=@(y,z) (y.*y+z.*z)/2/p;
%
y=-36:0.1:36;
x=f(y,0);
%
plot(x,y,'g','linewidth',2)
%axis equal
hold on
plot([c,c],[-L,L],'r','linewidth',2)
%% 抛物面
theta = linspace(-pi,pi,21);
r = linspace(36,0,8)';
Z = r*cos(theta);
Y = r*sin(theta);
X = (Z.^2+Y.^2)/60;
mesh(X,Y,Z,'FaceAlpha',0.5,'EdgeColor','k')
axis tight
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%%
%%


%%
F=nan(N,1);
for n=1:N
    % 光源上任一点
    x=c;y=rand*2*L-L;z=0;
    plot3(x,y,z,'mo')
    % 任取一方向
    theta=2*pi*rand;
    vz=2*rand-1;vx=sqrt(1-vz.^2).*cos(theta);vy=sqrt(1-vz.^2).*sin(theta);
    quiver3(x,y,z,10*vx,10*vy,10*vz,'MaxHeadSize',1,'color','b')
    %%%%%%%%%%%%%%
    %% 计算前进比例
    %         syms x y z vx vy vz k
    %         solve( 60*(x+vx*k)==(y+vy*k)^2+(z+vz*k)^2,k )
    %         x=c
    %         z=0
    %         f=solve( 60*(x+vx*k)==(y+vy*k)^2+(z+vz*k)^2,k );
    %         tmp_k=eval(f)
    %%
    tmp_k1= (30*vx + (900*vx^2 - 60*vx*vy*y + 900*vy^2 - vz^2*y^2 + 900*vz^2)^(1/2) - vy*y)/(vy^2 + vz^2);
    tmp_k2= -((900*vx^2 - 60*vx*vy*y + 900*vy^2 - vz^2*y^2 + 900*vz^2)^(1/2) - 30*vx + vy*y)/(vy^2 + vz^2);
    ng=tmp_k1*tmp_k2%验证用值 该值应该是负值
    k=max(tmp_k1,tmp_k2);%取正值
    
    %%
    a=0;
    while x+k*vx<21.6
        %% 镜面上的点
        plot3([x;x+k*vx],[y;y+k*vy],[z;z+k*vz],'b')
        x=x+k*vx;y=y+k*vy;z=z+k*vz;
        plot3(x,y,z,'mo')
        %% 该点的单位法向量
        nvx=-60/sqrt(3600+4*y*y+4*z*z);
        nvy=2*y/sqrt(3600+4*y*y+4*z*z);
        nvz=2*z/sqrt(3600+4*y*y+4*z*z);
        quiver3(x,y,z,10*nvx,10*nvy,10*nvz,'MaxHeadSize',1,'color','c')
        
        %% 反射光线向量
        tmp_a=2*(vx*nvx+vy*nvy+vz*nvz);
        vx=vx-tmp_a*nvx;
        vy=vy-tmp_a*nvy;
        vz=vz-tmp_a*nvz;
        quiver3(x,y,z,10*vx,10*vy,10*vz,'MaxHeadSize',1,'color','b')
        %%
        tmp_k1=  -((900*vx^2 - 60*vx*vy*y - 60*vx*vz*z - vy^2*z^2 + 60*x*vy^2 + 2*vy*vz*y*z - vz^2*y^2 + 60*x*vz^2)^(1/2) - 30*vx + vy*y + vz*z)/(vy^2 + vz^2);
        tmp_k2= (30*vx + (900*vx^2 - 60*vx*vy*y - 60*vx*vz*z - vy^2*z^2 + 60*x*vy^2 + 2*vy*vz*y*z - vz^2*y^2 + 60*x*vz^2)^(1/2) - vy*y - vz*z)/(vy^2 + vz^2);
        ze=tmp_k1*tmp_k2*(vy^2 + vz^2)*(vy^2 + vz^2)%验证用值 该值应该接近0
        k=max(tmp_k1,tmp_k2);%取非零值
        %%
        a=a+1;
        break
    end
    
    F(n)=a;

end

set(gca,'box','off')


