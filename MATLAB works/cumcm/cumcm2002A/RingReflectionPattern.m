% 镜面上圆环的反射图样
%%
%clc,clear
p=36*36/21.6/2;
c=p/2;
L=5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
theta = linspace(-pi,pi,21)';
r = linspace(0,36,7);
z = cos(theta)*r;
y = sin(theta)*r;
x = (z.^2+y.^2)/60;
%%
vx=x-c;
vy=y-L;
vz=z-0;
%% 镜面上点的单位法向量
nvx=-60./sqrt(3600+4*y.*y+4*z.*z);
nvy=2*y./sqrt(3600+4*y.*y+4*z.*z);
nvz=2*z./sqrt(3600+4*y.*y+4*z.*z);
%% 反射光线向量
tmp_a=2*(vx.*nvx+vy.*nvy+vz.*nvz);
vx=vx-tmp_a.*nvx;
vy=vy-tmp_a.*nvy;
vz=vz-tmp_a.*nvz;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
n=20;
X=repmat(x,1,1,n);
Y=repmat(y,1,1,n);
Z=repmat(z,1,1,n);

VX=repmat(vx,1,1,n);
VY=repmat(vy,1,1,n);
VZ=repmat(vz,1,1,n);

%kk(1,1,1:n)=linspace(21.6,5000,n);
kk(1,1,1:n)=linspace(21.6,500,n);
XC=repmat(kk,size(x,1),size(x,2));

M=(XC-X)./VX;
YC=Y+M.*VY;ZC=Z+M.*VZ;
%%
col=lines(7);
hold on
mesh(x,y,z,'FaceAlpha',0.5,'EdgeColor','r')
for k=[2,6,7]
    mesh(squeeze(XC(:,k,:)),squeeze(YC(:,k,:)),squeeze(ZC(:,k,:)),'FaceAlpha',0.3,'EdgeColor',col(k,:))
    
    % mesh(squeeze(XC(:,6,:)),squeeze(YC(:,6,:)),squeeze(ZC(:,6,:)),'FaceAlpha',0.3,'EdgeColor',c(6,:))
    % mesh(squeeze(XC(:,2,:)),squeeze(YC(:,2,:)),squeeze(ZC(:,2,:)),'FaceAlpha',0.3,'EdgeColor',c(2,:))
    
    plot3(squeeze(XC(1,k,:)),squeeze(YC(1,k,:)),squeeze(ZC(1,k,:)),'r','linewidth',2)
    plot3(squeeze(XC(6,k,:)),squeeze(YC(6,k,:)),squeeze(ZC(6,k,:)),'linewidth',2)
    plot3(squeeze(XC(11,k,:)),squeeze(YC(11,k,:)),squeeze(ZC(11,k,:)),'r','linewidth',2)
    plot3(squeeze(XC(16,k,:)),squeeze(YC(16,k,:)),squeeze(ZC(16,k,:)),'linewidth',2)
end
%view(90,0)
%%
figure
hold on
axis equal
axis([-175 70 -75 75])

plot(y,z,'o')
h = plot(YC(:,:,1),ZC(:,:,1),'YDataSource','ZC(:,:,k)','XDataSource','YC(:,:,k)');
title(['随着反射点考察半径的增大,唯一的汇聚点单调移动--';...
       '既当考察点确定时最多反射面上找到两对称的反射点  ';...
       '(不考虑xy平面的反射点)            '])
%while 1
for k=2:n
    refreshdata(h,'caller')
    drawnow
    %pause(0.5)
end
%end
%%
figure
hold on
mesh(x,y,z,'FaceAlpha',0.5,'EdgeColor','k')
plot3(c,L,0,'*')
u=XC(:,:,1)-XC(:,:,1);
v=YC(:,:,2)-YC(:,:,1);
w=ZC(:,:,2)-ZC(:,:,1);
quiver3(XC(:,:,1),YC(:,:,1),ZC(:,:,1),...
    u,v,w,...
    'showarrowhead','off','marker','+')
view(90,0)
surf(XC(:,:,1),YC(:,:,1),ZC(:,:,1),64*w/max(w(:)))
% for k=1:7
%     plot3([XC(1,1,1);XC(1,1,1)]',squeeze(YC(:,k,1:2))',squeeze(ZC(:,k,1:2))')%,'r','linewidth',2)
% end
surf(x,y,z,64*w/max(w(:)))
colorbar
title('半面汇聚(过聚焦)半面发散(欠聚焦),汇聚至考察点的反射点位于过聚焦半面内')