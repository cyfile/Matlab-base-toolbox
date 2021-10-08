
ss=[11008        9920        7872        5056        1728
    1728        5056        7872        9920       11008];
x = ss(1,:); y = ss(2,:);
sx = [x,-y,-x,y];
sy = [y,x,-y,-x];
% plot(sx,sy)
%%
gg=[11520       10624        8640        5824        2432
    1152        4672        7744       10048       11328];
x = gg(1,:); y = gg(2,:);
gx = [x,-y,-x,y];
gy = [y,x,-y,-x];
% plot(gx,gy)

%% VAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVVAVAVAVAVAVAVAVAV

Ux1 = reshape( typecast( single( sx ), 'uint8') , 4 ,[]);
Uy1 = reshape( typecast( single( sy ), 'uint8') , 4 ,[]);
% position = [Ux1; Uy1];
%%
Ux2 = reshape( typecast( single( gx ), 'uint8') , 4 ,[]);
Uy2 = reshape( typecast( single( gy ), 'uint8') , 4 ,[]);
%%
position = [Ux1 Ux2;Uy1 Uy2];