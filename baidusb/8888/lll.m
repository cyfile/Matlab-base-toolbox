% FTcharacter

figure
[p,t]=intwave('gaus1',6);
subplot(321)
plotyy(t,p,t,fftshift(abs(fft(p))))
hold on
t=-5:.15:5;
p=exp(-q.^2/2);
plot(t,p,'r')
plot(t,fftshift(abs(fft(p)))/30,'k')
[p,t]=wavefun('gaus1',6);%mexh gaus1 gaus2 Morlet,
subplot(322)
plotyy(t,p,t,fftshift(abs(fft(p))))

[p,t]=intwave('gaus2',6);
subplot(323)
plotyy(t,p,t,fftshift(abs(fft(p))))
[p,t]=wavefun('gaus2',6);%mexh gaus1 gaus2 Morlet,
subplot(324)
plotyy(t,p,t,fftshift(abs(fft(p))))

[p,t]=intwave('gaus3',6);
subplot(325)
plotyy(t,p,t,fftshift(abs(fft(p))))
[p,t]=wavefun('gaus3',6);%mexh gaus1 gaus2 Morlet,
subplot(326)
plotyy(t,p,t,fftshift(abs(fft(p))))

text(-15,5,'differential in Time-Domain','FontSize',18)
text(-15,3,'multiply \omega in Frequency-Domain','FontSize',18)