% ª•œ‡πÿ c(length(x))==max(c)
t=-5:.5:5;
y=pulstran(t,[3,0,-3],'rectpuls',1);
x=rectpuls(t,1);

c=xcorr(x,y);
d=xcorr(y,x);all(c-d<eps);%isequal(c,d)
a=xcorr(y,x(1:end-4));all(c-a<eps)

c1=xcorr(x,y,10);

subplot(411)
plot(t,y)
subplot(412)
plot(t,x)
subplot(413)
plot(c)
c(length(x))==max(c)
subplot(414)
plot(t,c1)