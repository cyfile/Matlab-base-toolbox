% 焦点光区细节
%%
clear,clc
p=36*36/21.6/2;
c=p/2;
% f=@(y,z) (y.*y+z.*z)/2/p;

%%
L=3;
N=1000000;
%N=10000000;
%
h=0.05;% 随机方向的z向分量
%%

ind=1;
Py=nan(N,1);Pz=nan(N,1);%Py0=nan(N/10,1);
for n=1:N
    %%
    x=c;y=rand*2*L-L;z=0;
    %plot3(x,y,z,'mo')
    vy=sign(rand)*(1-h*rand);
    tmp_theta=2*pi*rand;
    vx=sqrt(1-vy^2)*cos(tmp_theta);vz=sqrt(1-vy^2)*sin(tmp_theta);
    %quiver3(x,y,z,10*vx,10*vy,10*vz,'MaxHeadSize',1,'color','b')
    %%
    k = (30*vx + (900*vx^2 - 60*vx*vy*y + 900*vy^2 - vz^2*y^2 + 900*vz^2)^(1/2) - vy*y)/(vy^2 + vz^2);
    %%
    if x+k*vx>21.6
        continue
    end
    %%
    while x+k*vx<21.6
        %% 镜面上的点
        x=x+k*vx;y=y+k*vy;z=z+k*vz;
        %% 该点的单位法向量
        nvx=-60/sqrt(3600+4*y*y+4*z*z);
        nvy=2*y/sqrt(3600+4*y*y+4*z*z);
        nvz=2*z/sqrt(3600+4*y*y+4*z*z);
        %% 反射光线向量
        tmp_a=2*(vx*nvx+vy*nvy+vz*nvz);
        vx=vx-tmp_a*nvx;
        vy=vy-tmp_a*nvy;
        vz=vz-tmp_a*nvz;
        %%
        k=(30*vx + (900*vx^2 - 60*vx*vy*y - 60*vx*vz*z - vy^2*z^2 + 60*x*vy^2 + 2*vy*vz*y*z - vz^2*y^2 + 60*x*vz^2)^(1/2) - vy*y - vz*z)/(vy^2 + vz^2);
    end
    %%
    m=(25000+c-x)/vx;
    y=abs(y+m*vy);z=abs(z+m*vz);
   %     if y<1e3
    Py(ind) = y;
    Pz(ind) = z;
    ind=ind+1;
   %    end
end
Py(ind:end)=[];Pz(ind:end)=[];%Py0(ind:end)=[];

%% 画图

edges{1}=linspace(0,0.3e2,201);
edges{2}=linspace(0,0.6e2,401);

m=hist3([Pz Py],'Edges',edges);
%  hist(m(:),200)
M=[m(end:-1:1,end:-1:1),m(end:-1:1,:);m(:,end:-1:1),m];
imtool(M)
%%
edges{1}=linspace(0,1.5e3,401);
edges{2}=linspace(0,3.0e3,301);
m=hist3([Pz Py],'Edges',edges);
figure
plot(m(1,:))
set(gca,'xlim',[0 301],'XTick',[130 260],'XGrid','on')



