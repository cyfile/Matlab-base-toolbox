% set({line,patch,surface},'linesmoothing','on')
close all
figure('Renderer','zbuffer')
hold on
%%
h = plot(0,0,'XDataSource','x','YDataSource','y','linesmoothing','on');

%anno=annotation('arrow',[0 0],[0.1 0.1],'color','r');
htf = hgtransform('parent',gca,'Matrix',makehgtform('zrotate',pi/4));
fill([0 -0.08 0.15 -0.08]-0.12,[0 0.1 0 -0.1],'r',...
    'edgecolor','none','parent',htf,'linesmoothing','on',...
    'zdata',ones(4,1));%

axis([0,2*pi,-3 3])
axis equal
%%
filename = 'sinarrow.gif';
[im,map]=rgb2ind(frame2im(getframe(gca)),256);
imwrite(im,map,filename,'gif','LoopCount',Inf,'DelayTime',0.04);
%%
N=50;
xx=linspace(0,2*pi,N);

for k = 2:N;
    x=xx(1:k);
    y=sin(x);
    refreshdata(h)
    M= makehgtform('translate',[x(end) y(end) 0],'zrotate',pi/4*cos(x(end)));%,
    set(htf,'Matrix',M)
    %pause(0.04)
    drawnow
    [im,map]=rgb2ind(frame2im(getframe(gca)),256);
    imwrite(im,map,filename,'gif','WriteMode','append','DelayTime',0.04);
end
for k = 2:N
    y=sin(x+xx(k));
    refreshdata(h)
    M= makehgtform('translate',[x(end) y(end) 0],'zrotate',pi/4*cos(xx(k)));
    set(htf,'Matrix',M)
    %pause(0.04)
    drawnow
    [im,map]=rgb2ind(frame2im(getframe(gca)),256);
    imwrite(im,map,filename,'gif','WriteMode','append','DelayTime',0.1);
end

%movie(F)
%getframe
%imwrite

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = animatedline('MaximumNumPoints',200);
ylim([-1.5 1.5]);
xlim([0,2*pi]);
x = linspace(0,6*pi,1000);
y = sin(x);
for k = 1:length(x)
    if x(k)>2*pi
        xlim([x(k)-2*pi x(k)]);
    end
    addpoints(h,x(k),y(k));
    drawnow
end