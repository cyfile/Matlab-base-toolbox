% fft
clc
t=0:.1:20;
n=length(t);
k=floor(n/2);
a=cos(t);
b=cos(2*t);
c=[b(1:k),zeros(1,n-k)];
subplot(321)
plot(a)
subplot(323)
plot(b)
subplot(325)
plot(c)

subplot(322)
plot(abs(fft(a)))
subplot(324)
plot(abs(fft(b)))
subplot(326)
plot(abs(fft(c)))
hold on
plot(abs(fft(b)),'r')