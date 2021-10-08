% matlabª≠ ¿ΩÁµÿÕºworld map
load('topo.mat','topo')
wmap=topo(:,[181:360,1:180]);
%%
contour(-180:179,-89:90,wmap,[0 0],'k')
axis equal
box on
set(gca,'XLim',[-180 180],'YLim',[-90 90], ...
    'XTick',[-180 -90 0 90 180], ...
    'Ytick',[-90 -60 -30 0 30 60 90]);
%%
fid = fopen('04.txt');
C=textscan(fid,'%f%f%f');
[y,x,z]=C{:};
fclose(fid);

X = unique(x);
Y = flipud(unique(y));
Z=reshape(z,73,71)';
%%
hold on
k=image([-180 180],[87.5 -87.5],Z,'AlphaData',0.9);
uistack(k,'down')
%%
contour(X,Y,Z,10,'w--','ShowText','on')

%%%%%%%%%%%%%%%%%%%%

showdemo('earthmap')