% Linear 2-D Filter
figure
[f1,f2] = freqspace(64,'meshgrid');
r = sqrt(f1.^2 + f2.^2);
%%%%
subplot(241)
mesh(double(r<.5));
axis tight
subplot(242)
Cl=fftshift(ifft2(r<.5));
mesh(Cl)
axis tight
%%%%
subplot(243)
mesh(double(r>.5));
axis tight
subplot(244)
Ch=fftshift(ifft2(r>.5));
mesh(Ch)
axis tight
%%%%
subplot(245)
hl = ftrans2(fir1(12,0.5));
freqz2(hl);
subplot(246)
mesh(hl)
axis tight
%%%%
subplot(247)
hh = ftrans2(fir1(12,0.5,'high'));
freqz2(hh);
subplot(248)
mesh(hh)
axis tight