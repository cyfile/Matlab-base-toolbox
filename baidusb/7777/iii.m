% ffttimeshift1
A=[ones(1,16),zeros(1,240)];
subplot(311)
plot(A)
subplot(312)
Af=fft(A);
plot(abs(Af))
subplot(313);
plot(real(Af))
figure(2)
pause on
while 1
    A=circshift(A,[0,1]);
    subplot(311)
    plot(A)
    subplot(312)
    Af=fft(A);
    plot(abs(Af))
    subplot(313);
    plot(real(Af))
    pause (0.004)
end