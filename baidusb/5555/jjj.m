% matlab camera
[a,b]=meshgrid(-4:4);
A=a(:)';
B=b(:)';
C=[-4;4];
%%
figure('Position',[10 40 1000 640])
hgg = hggroup('Parent',gca);
line([A;A],[B;B],C,'Color','k','Parent',hgg)
line([A;A],C,[B;B],'Color','k','Parent',hgg)
line(C,[A;A],[B;B],'Color','k','Parent',hgg)
%%
daspect([1 1 1])

camproj('perspective')
campos([0,15,0])

axis vis3d
for i=1:60
   camorbit(6,0,'camera')
   drawnow
   pause(0.04)
end