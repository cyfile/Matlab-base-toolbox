% Frequency response 频率响应
num=poly(0);
den=poly([-1,-2]);
H=freqz(num,den);
A=abs(H);

subplot(211)
% plot(A0);
% plot(mag2db(A0))
semilogy(A,'linewidth',15)
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms z
syms w real
hz = z/(z+1)/(z+2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hejw=subs(hz,exp(1i*w));
Af=abs(subs(hejw,linspace(0,pi,513)));
subplot(212);hold on
h1=ezplot(abs(hejw),[0,pi]);
h2=plot(linspace(0,pi,513),Af,'r','linewidth',4);
uistack(h1,'top')
subplot(211)
semilogy(Af(1:end-1),'color','r','linewidth',9)
%%%%%%%%%%%%%%%%%%%%%
hn = iztrans(hz);
% F = fourier(hn);
% ezplot(abs(F),[0 pi])  %画不出来
h_n=subs(hn,0:511);
F=abs(fft(h_n));
% plot(F)
At=F(1:256)/F(1)*A0(1);

semilogy(1:2:512,At,'color','g','linewidth',3)

legend
%%%%%%%%%%%%%%%%%%%
th=iztrans(z/(z-1));
iztrans(th);
% F=fft(ones(1,98));
% semilogy(abs(F))