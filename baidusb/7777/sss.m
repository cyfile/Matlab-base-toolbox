% orthogonalwaveletfilters
% [Rf,Df] = biorwavf('bior3.5');
db8=dbwavf('db8');
% [Lo_D,Hi_D,Lo_R,Hi_R] = biorfilt(Df,Rf);
[Lo_D,Hi_D,Lo_R,Hi_R] = orthfilt(db8);

subplot(331);hold on;title('Dec. low-pass filter db3');
stem(Lo_D);
subplot(332);hold on;title('Rec. low-pass filter db3');
ad=(length(Lo_R)-length(Rf))/2;
stem(Lo_R);plot(db8,'r');
% plot([zeros(1,ad),Rf,zeros(1,ad)],'r');

subplot(334); stem(Hi_D); title('Dec. high-pass filter db3');
subplot(335); hold on;title('Rec. high-pass filter db3');
stem(Hi_R); plot(qmf(Lo_R),'*r')

fftld = fft(Lo_D); fftlr = fft(Lo_R);
ffthd = fft(Hi_D); ffthr = fft(Hi_R);
f=linspace(0,2*pi,length(Lo_D));

subplot(333); hold on;
plot(f,abs(fftld));plot(f,abs(fftlr),':')

subplot(336); hold on;
plot(f,abs(ffthd));plot(f,abs(ffthr),':')

subplot(339); plot(f, abs(fftlr.*fftld + ffthd.*ffthr));


rh=conv(Lo_D,Lo_R);
rg=conv(Hi_D,Hi_R);
subplot(337);hold on;
plot(rh);
plot(rg,'r');

subplot(338);hold on;
plot(dyadup(dyaddown(rh)),'s');
plot(dyadup(dyaddown(rg)),'or');