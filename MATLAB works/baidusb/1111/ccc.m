% CUMCM-2014B
%%%%%%%%%%%%%%%%%%%%%%%%%%

R=500/2;
W=25;%*4
n=500/W;
L=1200/2;
H=30;
tall=530-H;
%%
y2=linspace(-R,R,2*n+1);
y=y2(1:2:end-1);

yc=y2(2:2:end);
x=sqrt(R^2-yc.^2);

zo=zeros(1,4*n+1);
%%
%
% theta=linspace(0,2*pi,200);
% plot(R*cos(theta),R*sin(theta),'m-')
% hold on
% axis equal
%
axes('Position',[0 0 1 1]);
set(gca,'xtick',[],'ytick',[],'ztick',[])
set(gca,'box','off')
set(gca,'color',[.7569    0.8667    0.7765])
%
axis([-L L -R R x(1)-L H x(1)-L H]) %
hlight=light('Position',[-L -R 8*H],'Style','local');
light('Position',[-L R 4*H],'Style','infinite');
light('Position',[L -R 4*H],'Style','infinite');
light('Position',[L/2 R/2 2*H],'Style','infinite');

axis equal
view(3)
axis vis3d
shading flat%interp
set(gcf,'Renderer','opengl')


%%
xx=[zo;[-x(1);-x(1)],kron([x,-x],[1,1;1,1]);zo];
yy=[zo;kron([y,-y],[1,1;1,1]),[y(1);y(1)];zo];
%
%plot(xx(2,:),yy(2,:),'sr')
%
zz=kron(H*ones(1,4*n+1),[0;0;1;1]);
surface(xx,yy,zz,'facecolor',[0.8 0.7 0.6],'EdgeColor','none')%[0.7 0.5 0.05]
%[0.8 0.5 0.4]
%axis([-L L -R R x(1)-L H x(1)-L H]) %

% axis equal
% view(3)
% axis vis3d

%shading flat%interp


%%
hr=arrayfun(@(x) hgtransform('Parent',gca),1:n);
hl=arrayfun(@(x) hgtransform('Parent',gca),1:n);

zo=kron(H*ones(1,4),[0;0;1;1]);
xo=zeros(4,4);
yo=ones(4,4);
xl=L-x;
yl=y2(1:2:end);
for k=1:length(xl)
    %
    xo(2:3,2:3)=xl(k);
    hs=surface([zeros(1,4);0 xl(k) xl(k) 0;0 xl(k) xl(k) 0;zeros(1,4)],...
        [yl(k)*ones(1,4);yl(k) yl(k) yl(k+1) yl(k+1);yl(k) yl(k) yl(k+1) yl(k+1);yl(k)*ones(1,4)],...
        zo);
    set(hs,'Parent',hr(k))
    Tx = makehgtform('translate',[x(k) 0 0]);
    set(hr(k),'Matrix',Tx)
    %
    hs=surface([zeros(1,4);0 -xl(k) -xl(k) 0;0 -xl(k) -xl(k) 0;zeros(1,4)],...
        [yl(k)*ones(1,4);yl(k) yl(k) yl(k+1) yl(k+1);yl(k) yl(k) yl(k+1) yl(k+1);yl(k)*ones(1,4)],...
        zo);
    set(hs,'Parent',hl(k))
    Tx = makehgtform('translate',[-x(k) 0 0]);
    set(hl(k),'Matrix',Tx)
end
%%
P=(L-x(1))/2;
betaMax=asin(tall/2/P);%pi-
beatspace=linspace(0,betaMax,30);

for beta=beatspace(2:end);
   
    pcx=x(1)+P*cos(beta);
    pcy=P*sin(beta);
    for k=1:length(x)
        zeta=angle(pcx-x(k)+1i*pcy);
        Ry = makehgtform('translate',[x(k) 0 0],'yrotate',zeta);
        set(hr(k),'Matrix',Ry)
        Ry = makehgtform('translate',[-x(k) 0 0],'yrotate',-zeta);
        set(hl(k),'Matrix',Ry)
    end
    %shading flat
    drawnow
    pause(0.05)
   
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%



%%

R=500/2;
W=25;%*4
n=500/W;
L=1200/2;
H=30;
tall=530-H;
%%
y2=linspace(-R,R,2*n+1);
y=y2(1:2:end-1);

yc=y2(2:2:end);
x=sqrt(R^2-yc.^2);

zo=zeros(1,4*n+1);
%%
%
% theta=linspace(0,2*pi,200);
% plot(R*cos(theta),R*sin(theta),'m-')
% hold on
% axis equal
%
axes('Position',[0 0 1 1],'projection','perspective');

axis([-L L -R R x(1)-L H x(1)-L H]) %
axis  vis3d equal
view(3)
%axis
set(gca,'xtick',[],'ytick',[],'ztick',[])
set(gca,'box','off')
set(gca,'color',[.7569    0.8667    0.7765])
%shading flat%interp
set(gcf,'Renderer','opengl')
%
hlight=light('Position',[-L -R 8*H],'Style','local');
light('Position',[-L R 4*H],'Style','infinite');
light('Position',[L -R 4*H],'Style','infinite');
light('Position',[L/2 R/2 6*H],'Style','infinite');


%%
vx=[0 0 0 0 0 1;0 0 0 0 0 1;0 1 1 1 1 1;0 1 1 1 1 1];
vy=W*[0 0 0 0 1 0;0 0 1 1 1 0;1 0 1 1 1 1;1 0 0 0 1 1];
vz=H*[0 0 0 1 0 0;1 1 0 1 1 1;1 1 0 1 1 1;0 0 0 1 0 0];
vn=nan(4,6);
%vc=
%patch(vx,vy,vz,vz)

hr=arrayfun(@(x) hgtransform('Parent',gca),1:n);
hl=arrayfun(@(x) hgtransform('Parent',gca),1:n);

xl=L-x;
arrayfun(@(a,b,c) set(patch(a*vx,vy+b,vz,vn),'parent',c),xl,y,hr);
arrayfun(@(a,b,c) set(patch(a*vx,vy+b,vz,vn,'FaceColor',[0.8 0.5 0.4]),'parent',c),-xl,y,hl);

arrayfun(@(h,p)  set(h,'Matrix',makehgtform('translate',[p 0 0])),hr,x);
arrayfun(@(h,p)  set(h,'Matrix',makehgtform('translate',[p 0 0])),hl,-x);

%%
xx=[zo;[-x(1);-x(1)],kron([x,-x],[1,1;1,1]);zo];
yy=[zo;kron([y,-y],[1,1;1,1]),[y(1);y(1)];zo];
%
%plot(xx(2,:),yy(2,:),'sr')
%
zz=kron(H*ones(1,4*n+1),[0;0;1;1]);
surface(xx,yy,zz,'facecolor',[0.52 0.15 0.023],'EdgeColor','none')%[0.8 0.7 0.6]
%[0.8 0.5 0.4]

%%
P=(L-x(1))/2;
betaMax=asin(tall/2/P);%pi-
c=1;
betaSpace=linspace(0,c*betaMax,c*100);

for beta=betaSpace(2:end);
   
    pcx=x(1)+P*cos(beta);
    pcy=P*sin(beta);
    for k=1:length(x)
        zeta=angle(pcx-x(k)+1i*pcy);
        Ry = makehgtform('translate',[x(k) 0 0],'yrotate',zeta);
        set(hr(k),'Matrix',Ry)
        Ry = makehgtform('translate',[-x(k) 0 0],'yrotate',-zeta);
        set(hl(k),'Matrix',Ry)
    end
    %shading flat
    drawnow
    pause(0.05)
   
end

%%

 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%



%%

close all
R=500/2;
W=25;%*4
n=500/W;
L=1200/2;
H=30;
tall=530-H;
%%
R=R/W;
L=L/W;
H=H/W;
tall=tall/W;
%%
set(gcf,'Renderer','opengl')
axes('Position',[0 0 1 1],'projection','perspective',...
    'xtick',[],'ytick',[],'ztick',[],...
    'box','off',...
    'color',[.7569    0.8667    0.7765]);
%-L H
view(3)
colormap(cool)
hold on
%%
%%
y2=linspace(-R,R,2*n+1);
%y=y2(1:2:end-1);
yc=y2(2:2:end);
x=sqrt(R^2-yc.^2);

%%


%%
xl=L-x;
zo=zeros(size(xl));
%ribbon([-x-xl;-x;x;x+xl],[zo;zo;zo;zo])
P=xl(1)/2;
betaMax=asin(tall/2/P);%pi-
c=1;
betaSpace=linspace(0,c*betaMax,c*8);
for beta=betaSpace;
    zeta=angle(x(1)+P*cos(beta)-x+1j*P*sin(beta));
    xx=xl.*cos(zeta);
    yy=xl.*sin(zeta);
    sh=ribbon([-x-xx;-x;x;x+xx],[-yy;zo;zo;-yy]);
    tmp=arrayfun(@(var) [var;0;var],-yy,'uni',0);
    set(sh,{'cdata'},tmp')%,{'edgecolor'},{'k'}
   
    %camproj('perspective')
    axis equal
    axis([0 n+1 -2*R 2*R -L H ])
    %shading faceted%flat %interp
    drawnow
    pause(0.04)
end


%  vis3d
% view(3)


%

 

 