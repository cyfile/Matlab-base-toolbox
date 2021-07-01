% ÕýÏÒ ÓàÏÒµÄ ÆµÆ×
W=cos((1:200)*2*pi/50);
F=fftshift(fft(W));
W2=sin((1:200)*2*pi/50);
F2=fftshift(fft(W2));
%%
subplot(321)
plot(W)
subplot(322)
plot(W2)
%%
subplot(323)
plot(abs(F))
subplot(324)
plot(abs(F2))
%%

F_max=F(abs(F)>20);
F2_max=F2(abs(F2)>20);

2*(angle(F_max)-angle(F2_max))
F_max./F2_max

subplot(325)
compass(F_max)
hold on
compass(F2_max,'g')

 

