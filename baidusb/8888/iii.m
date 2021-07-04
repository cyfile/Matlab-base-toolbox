% orthogonalandcorrelation

%%orthogonal in frequency domain
%%correlation in time domain
close all
clear


lb = -8; ub = 8; n = 2^10;
ff=0:1023;
ff2=ff(1:n/2);

[f,p,t] = meyer(lb,ub,n);
%-------------------------------------------------
subplot(221)
plot(t,f,'r')
hold on
plot(t,p)
grid on
title(num2str(sum(f.*p),'%6.4f'))

%---------------------------------------------------
subplot(425)
f2=circshift(f,[0,n/16]);
plot(t,f,'r')
hold on
plot(t,f2,'r')
title(num2str(sum(f.*f2),'%6.4f'))

%----------------------------------------
subplot(427)
[~,fa]=max(f);
[~,pa]=max(p);
dif=fa-pa;
newf=f((dif+1):end);
newp=p(1:(end-dif));

plot(newf,'r')
hold on
plot(newp)
grid on
title(num2str(sum(newf.*newp),'%6.4f'))
%-------------------------------------------------------

subplot(222)
fw=fft(f);
pw=fft(p);

frt=ifft(fw.*conj(fw));
frt2=frt(1:n/2);

prt=ifft(pw.*conj(pw));
prt2=prt(1:n/2);

plot(ff2,frt2*16/n,'r');
hold on
plot(ff2,prt2*16/n);
grid on
%---------------------------------------------------

subplot(426)
ts=16/n;
fs=1/16;
sn=1/fs;
magpw=abs(ts*pw).^2;%*16/n
mpw=circshift(magpw,[0,100]);
mpw=mpw(1:200);
plot(mpw)
hold on
mpw2=circshift(mpw,[0,sn]);
plot(mpw2)
mpw3=circshift(mpw,[0,2*sn]);
plot(mpw3)
plot(abs(mpw3+mpw2+mpw),'m')
hold off
%--------------------------------------------------
subplot(428)
fprt=ifft(fw.*conj(pw));
fprt2=fprt(1:n/2);

plot(ff,fprt)