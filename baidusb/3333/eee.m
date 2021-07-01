% pixel image »­ÏñËØÍ¼
A=imread('04.jpg','jpg');
P = impixel(A);
bmap=P/255;
%%
m=12;
n=17;
figure;
colormap(bmap)
bird=nan(m+1,n+1);
ph=pcolor(bird);%
set(ph,'cdatamapping','direct')
set(gca,'color',[.7 .6 .8])
axis equal
box off

for k=1:length(bmap)
    a=0;
    while ~isempty(a)
        try
            [a,b]=ginput(1);
        catch
            break
        end
        x=floor(a);
        y=floor(b);
        if bird(y,x)==k
            bird(y,x)=nan;
        else
            bird(y,x)=k;
        end
        set(ph,'cdata',bird)
        drawnow;
    end
end
figure
ph=pcolor(bird);
set(ph,'cdatamapping','direct','EdgeColor','none')
colormap(bmap)
set(gca,'color',[55 183 64]/255)
axis equal
save('flappybird','bird','bmap')