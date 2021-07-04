% sound-----Nyquist's Theorem
%Nyquist's Theorem
Fs=11025;
pt=1;
gw=@(f) cos(2*pi*f*linspace(0,pt,pt*Fs));

figure
xlabel('ms')
for k=1:20
    w=gw(k*500);
    subplot(211)
    plot(w(1:100))
    xlabel('ms')
    title(['Frequency:',num2str(k*500),'Hz']);
    subplot(212)
    magf=fftshift(abs(fft(w(1:100))));
    f=-11.025:22.05/99:11.025;
    plot(f,magf)
    xlabel('kHz')
    pause(0.1)
    wavplay(w,Fs);
end