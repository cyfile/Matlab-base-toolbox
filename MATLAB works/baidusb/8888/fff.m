% compressionusingfft

exp=7;
t=linspace(0,1,2^exp);
f=sin(4*pi*t)+1/2*cos(10*pi*t);
h=figure;
subplot(221)
plot(t,f)

subplot(222)
ff=fft(f);
mff=abs(ff);
plot(mff(1:2^(exp-3)))

subplot(221)
plot(t,ifft(ff),'r')

subplot(224)
nff=ff;
nff(mff<.2*max(mff))=0;
mnff=abs(nff);
plot(mnff(1:2^(exp-3)))

subplot(223)
nf=ifft(nff);
plot(t,nf)