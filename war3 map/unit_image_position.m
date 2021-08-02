192/2*128==12288;

%%
% r = 11264;
% zz = pi/20:pi/10:pi/2;
% xx = cos(zz);
% fun = @(m) sum( 64*mod(m*xx,64)-mod(m*xx,64).^2  );
% [r1,fval,exitflag,output] = fminbnd(fun,r-1024,r+512)
% xxx = r1*xx
% mod(xxx,64)
% xxx - mod(xxx,64)
%%
R = zeros(1,10);
for k = 0:8
x2=11904-k*64;y2=1024+k*64;
r = hypot(x2 ,y2);% 11904 ,1024
z = (0:pi/10:pi/2-0.1)+ atan(y2/x2);
xy =r * [cos( z ); sin( z )];
d = mod(xy,64);
R(k+1)=sum( prod( 64*d-d.^2  ) );
end

tmp=round(xy/64)*64
gx = tmp(1,:);
gy = tmp(2,:);


%% VAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVVAVAVAVAVAVAVAVAV
xx = [sx,-sy,-sx,sy];
yy = [sy,sx,-sy,-sx];
% plot(xx,yy)
Ux1 = reshape( typecast( single( xx ), 'uint8') , 4 ,[]);
Uy1 = reshape( typecast( single( yy ), 'uint8') , 4 ,[]);
position = [Ux1; Uy1];
%%
xx = [gx,-gy,-gx,gy];
yy = [gy,gx,-gy,-gx]; 
% plot(xx,yy)
Ux2 = reshape( typecast( single( xx ), 'uint8') , 4 ,[]);
Uy2 = reshape( typecast( single( yy ), 'uint8') , 4 ,[]);
position = [Ux1 Ux2;Uy1 Uy2];