% biorthogonalwaveletfilters
[Rf,Df] = biorwavf('bior3.5');

[Lo_D,Hi_D,Lo_R,Hi_R] = biorfilt(Df,Rf);

subplot(331);hold on;title('Dec. low-pass filter bior3.5');
stem(Lo_D);plot(Df,'r')
subplot(332);hold on;title('Rec. low-pass filter bior3.5');
ad=(length(Lo_R)-length(Rf))/2;
stem(Lo_R);plot([zeros(1,ad),Rf,zeros(1,ad)],'r');

subplot(334); stem(Hi_D); title('Dec. high-pass filter bior3.5');
subplot(335); stem(Hi_R); title('Rec. high-pass filter bior3.5');

fftld = fft(Lo_D); fftlr = fft(Lo_R);
ffthd = fft(Hi_D); ffthr = fft(Hi_R);
f=linspace(0,2*pi,length(Lo_D));

subplot(333); hold on;
plot(f,abs(fftld));plot(f,abs(fftlr),':')

subplot(336); hold on;
plot(f,abs(ffthd));plot(f,abs(ffthr),':')

subplot(339); plot(f, abs(fftlr.*fftld + ffthd.*ffthr));


rh=conv(Lo_D,fliplr(Lo_R));
rg=conv(Hi_D,fliplr(Hi_R));
subplot(337);hold on;
plot(rh);
plot(rg,'r');

subplot(338);hold on;
plot(dyadup(dyaddown(rh,0),0),'s');
plot(dyadup(dyaddown(rg)),'or');