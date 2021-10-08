% matlabª≠Õº√¸¡Ó
%%%%%%%%%%%%%%%%%%%%%%
%figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
h=allchild(gcf);
set(h,'visible','off')
axes('Position',[0 0 1 1]);
set(gca,'xtick',[],'ytick',[])
set(gca,'box','off')
% set(gca,'color',[.7569    0.8667    0.7765])
whitebg([.7569    0.8667    0.7765])
whitebg(gcf,[.7569    0.8667    0.7765])


%%%%%%%%%%%%%%%%%%
%subplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
set(gcf,'defaultaxesnextplot','add')
set(gcf,'defaultaxesdataaspectratio',[1 1 1])
set(gcf,'defaultaxesDataAspectRatioMode','manual')
set(gcf,'defaultaxesPlotBoxAspectRatioMode','manual')

get(gcf,'defaultaxesPlotBoxAspectRatio');

 

%%%%%%%%%%%%%%%%%%%

%axes position

%%%%%%%%%%%%%%%%%%%

set(gca, 'Position', get(gca, 'OuterPosition') - ...
get(gca, 'TightInset') * [-1.1 0 2.2 0; 0 -1.1 0 1.1; 0 0 0 0; 0 0 0 1.1]);

 

 %%%%%%%%%%%%%%%%%%%%%%%%%%%

colordef

whitebg

whitebg('w')
whitebg([.7569 .8667 .7765])

colordef white