% matlabª≠¡¢ÃÂ‘≤«Ú
figure
daspect([1 1 1])
light
[x,y,z] = sphere;
c=ones(size(x));
hold on

surf(x,y,z,5*c)  % sphere centered at origin
surf(2*x+3,2*y-2,2*z,10*c)  % sphere centered at (3,-2,0)
surf(3*x,3*y+1,3*z-3,20*c)  % sphere centered at (0,1,-3)
surf(3*x+6,2*y+2,z-9,30*c)
surf(2*x+16,2*y+12,2*z-9,40*c)

shading interp

%%%%%%%%%%%%%%%%%%%%%%

figure
daspect([1 1 1])
light
[x,y,z] = sphere;
c=ones(size(x));
hold on

surf(x,y,z,'facecolor',[0.4 0.6 0.8],'EdgeColor','none');
surf(x+3,y,z,'facecolor',[0.8 0.8 0.4],'EdgeColor','none');
surf(x+6,y,z,'facecolor',[0.8 0.4 0.6],'EdgeColor','none');