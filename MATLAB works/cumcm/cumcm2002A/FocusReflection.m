% 入射光线通过焦点附近的反射图样
%%
clc,clear
p=36*36/21.6/2;
c=p/2;
%
n=11;
l=5;
L(1,1,1:n)=linspace(-l,l,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 镜面上的点
theta = linspace(-pi,pi,81)';
r = [24 27 30 33 36];
z = cos(theta)*r;
y = sin(theta)*r;
x = (z.^2+y.^2)/60;
%
X=repmat(x,1,1,n);
Y=repmat(y,1,1,n);
Z=repmat(z,1,1,n);
%% 入射向量
VX=repmat(x-c,1,1,n);
VY=bsxfun(@minus,y,L);
VZ=repmat(z-0,1,1,n);
%% 镜面上点的单位法向量
nvx=-60./sqrt(3600+4*y.*y+4*z.*z);
nvy=2*y./sqrt(3600+4*y.*y+4*z.*z);
nvz=2*z./sqrt(3600+4*y.*y+4*z.*z);
%
NVX=repmat(nvx,1,1,n);
NVY=repmat(nvy,1,1,n);
NVZ=repmat(nvz,1,1,n);
%% 反射光线向量
tmp_a=2*(VX.*NVX+VY.*NVY+VZ.*NVZ);
VX=VX-tmp_a.*NVX;
VY=VY-tmp_a.*NVY;
VZ=VZ-tmp_a.*NVZ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
a=25000;
a=250;
XC=a*ones(size(x,1),size(x,2),n);

M=(XC-X)./VX;
YC=Y+M.*VY;ZC=Z+M.*VZ;
%%
% YC(YC>100 | YC <100)=nan;
% ZC(ZC>100 | ZC <100)=nan;
%%
col=lines(7);
figure
hold on
%mesh(x,y,z,'FaceAlpha',0.5,'EdgeColor','r')
for k=1:5
    %%
    mesh(squeeze(XC(:,k,:)),squeeze(YC(:,k,:)),squeeze(ZC(:,k,:)),'FaceAlpha',0,'EdgeColor',col(k,:))
    
%     plot3(squeeze(XC(:,k,:)),squeeze(YC(:,k,:)),squeeze(ZC(:,k,:)),'color',col(k,:))

    %%
end
view(90,0)
%axis([-50 50 -50 50])

%%
figure
hold on
axis equal
axis([-50 50 -50 50])

plot(y,z,'o')
h = plot(YC(:,:,1),ZC(:,:,1),'YDataSource','ZC(:,:,k)','XDataSource','YC(:,:,k)');
%while 1
for k=[2:n,n-1:-1:1]
    refreshdata(h,'caller')
    drawnow
    pause(0.05)
end
%end
%%
figure
hold on
mesh(x,y,z,'FaceAlpha',0.5,'EdgeColor','k')
plot3(c,squeeze(L),0,'*')
u=XC(:,:,2)-XC(:,:,1);
v=YC(:,:,2)-YC(:,:,1);
w=ZC(:,:,2)-ZC(:,:,1);
C=u.*u+v.*v+w.*w;
quiver3(XC(:,:,1),YC(:,:,1),ZC(:,:,1),...
    u,v,w,...
    'showarrowhead','off','marker','+')
view(90,0)
surf(XC(:,:,1),YC(:,:,1),ZC(:,:,1),64*C/max(C(:)))
% for k=1:7
%     plot3([XC(1,1,1);XC(1,1,1)]',squeeze(YC(:,k,1:2))',squeeze(ZC(:,k,1:2))')%,'r','linewidth',2)
% end
surf(x,y,z,64*C/max(C(:)))
colorbar