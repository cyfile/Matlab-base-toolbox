% Ä§·½µÄÒ»¿é
ax = axes('XLim',[-2 2],'YLim',[-2 2],...
 'ZLim',[-2 2]);
view(3); grid on; axis equal
set(gcf,'Renderer','opengl')
%%
%%%%%%%%%%%%%%%%%%%%%
hcube = hgtransform('Parent',ax);
hcube2 = hgtransform('Parent',ax);
%%
%%%%%%%%%%%%%%%%%%%%%%%%
[x,y]=meshgrid(-0.5:.5);
z=0.5*ones(2);
h(1) = surface(x,y,z,'FaceColor',hsv2rgb([1 0.4 1.0]));
h(2) = surface(x,y,-z,'FaceColor',hsv2rgb([5/6 0.4 1.0]));
h(3) = surface(z,x,y,'FaceColor',hsv2rgb([4/6 0.4 1.0]));
h(4) = surface(-z,x,y,'FaceColor',hsv2rgb([3/6 0.4 1.0]));
h(5) = surface(y,z,x,'FaceColor',hsv2rgb([2/6 0.4 1.0]));
h(6) = surface(y,-z,x,'FaceColor',hsv2rgb([1/6 0.4 1.0]));
%%
set(ax,'cameraviewanglemode','manual')
set(h,'Parent',hcube)
h2 = copyobj(h,hcube2);

light
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ax = axes('XLim',[-2 2],'YLim',[-2 2],...
 'ZLim',[-2 2]);...
    %,'cameraviewanglemode','manual'
view(3); grid on; axis equal
set(gcf,'Renderer','opengl')

hcube = hgtransform('Parent',ax);
%%
[u v w]=ndgrid(-.5:.5);
verts=[u(:),v(:),w(:)];
%%
col=prism(6);
tmp=hsv;
col=tmp(5:11:64,:);
fcol=kron(col,[1;1]);
%%
faces=[1 2 3;2 3 4;...
    2 4 6;4 6 8;...
    1 3 5;3 5 7;...
    5 6 7;6 7 8;...
    3 4 7;4 7 8;...
    1 2 5;2 5 6];
%%
ph=patch('Faces',faces...
    ,'Vertices',verts...
    ,'FaceColor','flat'...
    ,'FaceVertexCData',fcol...
    ,'EdgeColor','none'...
    ,'Parent',hcube);
%%
set(ax,'cameraviewanglemode','manual')
light