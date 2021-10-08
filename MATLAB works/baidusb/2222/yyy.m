% bird
%% Constant
% 2048 1536
% 1024 768  --1:0.75
% 773 580  ×4/3 --1:0.75
%屏幕
winL=1536;
winH=2048;
%管道
piH=118;
piW=268;
pad=10;%大小管道宽度之差
pipeh=838;%两管道水平间距
pipev=524;%两管道垂直间距
%地面
grd=256;
belt=76;
%小鸟
bL=180;
bp=468;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate Colormap
%%% output variable: Cmap
%------------ for pipe Cmap(1:30)----------------
CN=20;
%Cmap=hsv2rgb([0.4*ones(CN,1) abs(cos(linspace(pi/4,pi,CN)))' sin(linspace(pi/4,pi,CN))']);
cform = makecform('lab2srgb');
lab=[35+60*sin(linspace(pi/4,pi,CN)').^2 -23.5*ones(CN,1) 47*ones(CN,1)];
map_pipe=applycform(lab,cform);
map_pipe(30,3)=0;
%------------ for ground Cmap(31:40)-----------------
map_belt=[156 231 89;116 191 46];
map_soil=[221 216 148;216 168 76;84 128 33;229 253 140;83 55 70];
map_ground(1:2,:)=map_belt/255;
map_ground(6:10,:)=map_soil/255;
%------------ for bird Cmap(41:50)-------------------
load('flappybird2')
%map_bird
%------------ for all Cmap---------------------------
Cmap=[map_pipe;map_ground;map_bird];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initialize figure
figure('name','flappy bird simulating'...
    ,'colormap',Cmap...,'defaultsurfacefacecolor','texturemap'...
    ,'defaultsurfacecdatamapping','direct'...
    ,'Renderer','opengl')

axes('position',[0,0,0.75,1])
axis equal
axis([0  winL 0 winH])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initialize object
%%%
%-------------- pipe ---------------
ph1=piW/2;
ph2=ph1-pad;
PipeW={[-ph2 ph2];[-ph1 ph1];[-ph1 ph1];[-ph2 ph2]};
pv1=pipev/2;
pv2=piH+pv1;
pv3=winH/1.5+pv2;
PipeH={[-pv3 -pv2-6];[-pv2 -pv1];[pv1 pv2];[pv2+6 pv3]};
%%
Pipecol = surface(ones(2),1:CN...
    ,'facecolor','texturemap'...
    ,'edgecolor','k'...
    ,'linewidth',2);
Pipecol(2:4)=arrayfun(@(x) copyobj(Pipecol,gca),2:4);
set(Pipecol,{'xdata'},PipeW,{'ydata'},PipeH)
Pipe1 = hgtransform('Parent',gca);
set(Pipecol,'Parent',Pipe1)
Pipe2 = copyobj(Pipe1,gca);
Pipe3 = copyobj(Pipe1,gca);
%%
%管道中心垂直区间interval:[pv2+piH+grd,winH-pv2-piH];
y_min=pv2+piH+grd;
y_max=winH-pv2-piH;
ty=(y_max-y_min)*rand(1,3)+y_min;
%管道中心水平区间[0,3*pipeh)-(pipeh-winL/2)
tx=mod([0 pipeh 2*pipeh]+rand*3*pipeh,3*pipeh)-(3*pipeh/2-winL/2);
M1 = makehgtform('translate',[tx(1) ty(1) 0]);
set(Pipe1,'Matrix',M1)
M2 = makehgtform('translate',[tx(2) ty(2) 0]);
set(Pipe2,'Matrix',M2)
M3 = makehgtform('translate',[tx(3) ty(3) 0]);
set(Pipe3,'Matrix',M3)
%%
%======================================
% --------- ground ----------
pad=10;
blt_u=grd-2*pad;
blt_c=blt_u-belt/2;
blt_d=blt_u-belt;
%%
[X,Y] = meshgrid([-pad,winL+pad],...
    [-pad,blt_d-2*pad,blt_d-pad,blt_c,grd-pad,grd]);
Z=20*ones(size(X));
soil = surface(X,Y,Z,(1:5)'+35 ...
    ,'EdgeColor','none');
%%
x=0:50:2*pipeh;
X=[x;x-50];
y=[blt_u;blt_d];
Y=repmat(y,1,size(X,2));
Z=30*ones(size(X));
C=31+mod(1:size(X,2),2);
belt = surface(X,Y,Z,C...
    ,'EdgeColor','none');
%%
%=========================================
% ---------- bird ------------
[m,n]=size(bird);
hold on
pbird=pcolor(bL*(1:n)/n+(bp-bL/2),...
    bL/n*(1:m)+(y_max-y_min)*.5+y_min,...
    bird+40);
set(pbird,'EdgeColor','none'...
    ,'zdata',40*ones(size(bird)));
%%%%%
% a=getframe;
% [im,map] = frame2im(a);
% %rgb = ind2rgb(im,map);
% imwrite(im,'p.jpg')