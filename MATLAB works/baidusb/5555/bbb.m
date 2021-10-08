% axes camera…Ë÷√
hist(randn(1,100))
set(gca,'Cameraupvector',[-1 0 0],'yaxislocation','right')
a=get(gca,'cameraposition');
set(gca,'cameraposition',[a(1:2),-a(3)])