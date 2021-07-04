% 3wt
t=linspace(-1,1,512);
s=1-abs(t);
subplot(411);
plot(s)


wname='sym4';
c=cwt(s,16,wname);
subplot(412);
plot(c)


[C,L] = wavedec(s,4,wname);
d = detcoef(C,L,4);
subplot(413)
plot(-d)
norm(s-waverec(C,L,wname))

swc=swt(s,4,wname);
subplot(414)
plot(-swc(4,:))
norm(s-iswt(swc,wname))