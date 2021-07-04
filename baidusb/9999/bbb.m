% animationfcn

h=figure;
F(1)=getframe;
psn=get(h,'position');
npsn=0.5*psn;
set(h,'position',npsn)
F(2)=getframe(h);
colormap cool;
pcolor(magic(4));
for n=1:10;
    set(h,'position',[npsn(1)+20*n,npsn(2),npsn(3)+20*n,npsn(4),]);
    F(n+2)=getframe;
end


movie(F,2);