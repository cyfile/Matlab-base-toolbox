% 离散系统的系统函数和连续系统的系统函数
num=poly(0);
den=poly([-1,-2]);
figure
%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
subplot(323)
Az=freqz(num,den);
plot(mag2db(abs(Az)),'linewidth',6)
%%%%%%%%%%%%%%%%%%%%%%
hold on
syms z s w
b=poly2sym(num,z);
a=poly2sym(den,z);
hz=b/a;

hejw=subs(hz,exp(1i*w));
% ezplot(abs(hejw))%这个画不出来
A=abs(subs(hejw,linspace(0,pi,513)));
plot(mag2db(A(1:end-1)),'color','r','linewidth',2)

subplot(321)
hn = iztrans(hz);
% F = fourier(hn);DTFT
% ezplot(abs(F),[0 pi])
h_n=subs(hn,0:31);
plot(h_n,'o')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(324)
As=freqs(num,den);
%plot(abs(As))
plot(mag2db(abs(As)),'linewidth',6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
syms s w
b=poly2sym(num,s);
a=poly2sym(den,s);
hs=b/a;

hjw=subs(hs,1i*w);
% ezplot(abs(hjw))%这个可以画出来
omega=logspace(-2,1,200);%这个omega随便取，这里这样取是为了和上面的曲线重合
A=abs(subs(hjw,omega));
plot(mag2db(A(1:end-1)),'color','r','linewidth',2)

subplot(322)
ht = ilaplace(hs);
%ezplot(ht)
% F = fourier(ht);FT
% ezplot(abs(F))
h_t = subs(ht,0:.5:31);
plot(h_t)
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(325)
h_n=subs(hn,0:63);
Fn=abs(fft(h_n))/64;
plot(mag2db(fftshift(Fn)))

subplot(326)
h_t = subs(ht,0:.5:31.5);
Ft=abs(fft(h_t))/64;
plot(mag2db(fftshift(Ft)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% semilogy(A2,'color','r')
%%%%%%%%%%%%%%%%%%%
hz = z/(z-1);
hn = iztrans(hz)
hn = iztrans(hn)