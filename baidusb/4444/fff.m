% 句柄图形对象findall findobj get(h,'type') 'handleVisibility'
findall(0)
findobj(gca)
allchild(gcf)
patch;surface;text;line;axes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
axes
hold on
axis equal

h=allchild(gcf);
get(h,'type')
toolbar=allchild(h(end))
get(toolbar,'type')
inspect(toolbar(6))


fh = @(x,y) sqrt(x.^2 + y.^2 - 1);
ezplot(fh)
plot(1:4)
rectangle('Position',[0,0,3,2],'Curvature',[1,1])
%在当前的axes上，放这个annotation
ah=allchild(gca);
get(ah,'type')% line rectangle hggroup
h2=findobj(gca,'type','line')
x=get(h2,'xdata')
y=get(h2,'ydata')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
axes
get(allchild(gca),'type')
findobj('type','text')%虽然有对象，但是handlevisibility为off，故找不到
tth=findall(gcf,'type','text')
get(tth,'handlevisibility')
set(tth,'handlevisibility','on')
findobj('type','text')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hg=annotation('rectangle',[0.25 0.25 0.5 0.5],...
 'FaceAlpha',.2,'FaceColor','g','EdgeColor','m');
%会新建一个隐藏的axes，放这个annotation
get(hg,'type')
findall(gcf,'type','hggroup')
set(hg,'handlevisibility','on')
findobj('type','hggroup')%祖先的visibility是off，所以仍旧找不到
set(get(hg,'parent'),'handleVisibility','on')
findobj('type','hggroup')