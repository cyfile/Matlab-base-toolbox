% 5 and 12 equal tone temperaments,五音律（宫,商,角,徵,羽）和12音律
do=1;
q=2^(1/12);
lev=0:35;
kk=lev+1;
note=do*q.^(lev);
oct=[1,3,5,6,8,10,12];
oct12=12+oct;
oct24=24+oct;

%subplot(121)
hold on
plot(note,'-+k')
plot(kk(oct),note(oct),'og',kk(oct12),note(oct12),'om',kk(oct24),note(oct24),'or')

ylim([0,8])
set(gca,'XTick',[oct,oct12,oct24])
set(gca,'XTickLabel',{'1','2','3','4','5','6','7','1','2','3','4','5','6','7','1','2','3','4','5','6','7'})
set(gca,'XGrid','on')
text(oct(1),.5,'宫')
text(oct(2),.5,'商')
text(oct(3),.5,'角')
text(oct(5),.5,'徵')
text(oct(6),.5,'羽')

q5=1.5;
lev=0:5;
kk=lev+1;
note=do*q5.^(lev);

%subplot(122)
%hold on
plot(note,'-*b')
x=[ones(1,6);1 8 15 22 29 36];
plot(x,[note;note],'c')

plot([oct(2),15,15],[note(3)/2,note(3)/2,note(3)],'--c')
plot([oct(6),22,22],[note(4)/2,note(4)/2,note(4)],'--c')
plot([oct(3),29,29],[note(5)/4,note(5)/4,note(5)],'--c')

plot([1,36,36],[note(6)/8,note(6)/8,note(6)],'y')