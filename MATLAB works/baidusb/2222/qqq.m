% parallel-beam projection and fan-beam projection， radon变换和Projection Transform
figure('defaultaxesXtickmode','manual'...
    ,'defaultaxesytickmode','manual'...
    ,'defaultaxesbox','on')
%%
r=3;c=4;
gh=1/r;gw=1/c;
ph=gh*0.05;pw=gw*0.05;%左下角的pad
ah=gh*0.9;aw=gw*0.9;%axes的height and width
[xw,yh]=meshgrid((0:gw:1-gw/2)'+pw,(0:gh:1-gh/2)'+ph);
pos=[xw(:),yh(:),aw(ones(r*c,1)),ah(ones(r*c,1))];
mash=flipud(reshape(1:r*c,r,c));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
P=phantom(256);
output_size = max(size(P));
axes('pos',pos(mash(1,1),:))
imshow(P)
axes('pos',pos(mash(1,4),:))
imshow(P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
axes('pos',pos(mash(2,2),:))
theta3 = 0:2:178;
[R3,xp] = radon(P,theta3);
subimage(256*R3./max(R3(:)), hot)
axis square
%
axes('pos',pos(mash(2,1),:))
dtheta1 = theta3(2) - theta3(1);
I3 = iradon(R3,dtheta1,output_size);
imshow(I3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
axes('pos',pos(mash(3,2),:))
theta1 = 0:10:170;
[R1,xp] = radon(P,theta1);
imagesc(theta1,xp,R1)
colorbar
%
axes('pos',pos(mash(3,1),:))
dtheta1 = theta1(2) - theta1(1);
I1 = iradon(R1,dtheta1,output_size);
imshow(I1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
D = 250;
%-------------------------------------
axes('pos',pos(mash(2,3),:))
dsensor3 = 0.25;
F3=fanbeam(P,D,'FanSensorSpacing',dsensor3);
subimage(256*F3./max(F3(:)), hot)
axis square
%
axes('pos',pos(mash(2,4),:))
Ifan3 = ifanbeam(F3,D,...
    'FanSensorSpacing',dsensor3,'OutputSize',output_size);
imshow(Ifan3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
axes('pos',pos(mash(3,3),:))
dsensor1 = 2;
[F1, sensor_pos1, fan_rot_angles1] = ...
    fanbeam(P,D,'FanSensorSpacing',dsensor1);
imagesc(fan_rot_angles1, sensor_pos1, F1)
colorbar
%
axes('pos',pos(mash(3,4),:))
Ifan1 = ifanbeam(F1,D,...
    'FanSensorSpacing',dsensor1,'OutputSize',output_size);
imshow(Ifan1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
axes('pos',pos(mash(1,2),:))
F = para2fan(R3, D);
subimage(256*F./max(F(:)), hot)
axis square
%
axes('pos',pos(mash(1,3),:))
R = fan2para(F3,D,...
    'FanSensorSpacing',dsensor3);
subimage(256*R./max(R(:)), hot)
axis square