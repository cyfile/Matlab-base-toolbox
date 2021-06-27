function bb=passfilter(ys)


Fs = 44100;
aa= fft(ys);
an = length(aa);
f = an/Fs;
lf = round(100/f);
hf = round(10000/f);
aa([1:lf hf:an-hf+2 an-lf+2:end])=0;
bb= ifft(aa);
% plot(ifft(aa))
