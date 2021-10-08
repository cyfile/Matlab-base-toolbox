% orthandcorr_haar

%%orthogonal in frequency domain
%%correlation in time domain
close all
clear

T=5;
n = 2^6;
N=T*n;

ts=T/N;
fr=0:n;


t=linspace(-T/2,T/2,N);
zl=N/2-n/2;
z=zeros(1,zl);
f=[z,ones(1,n),z];
p=[z,ones(1,n/2),-ones(1,n/2),z];

% % % [f,p,t] = meyer(lb,ub,n);
% % % [p,t] = morlet(lb,ub,n);
% % % f=p;
%-------------------------------------------------
subplot(421)
hold off
plot(t,f,'r')
title('haar: \phi')
%
subplot(423)
plot(t,p)
title('haar: \psi')
grid on


%---------------------------------------------------
subplot(426)
ff=fft(f);
pf=fft(p);
hold on
plot(fr,abs(ff(fr+1)),'r')
plot(fr,abs(pf(fr+1)))

%-------------------------------------------------------

subplot(422)
frt=ifft(ff.*conj(ff));
plot(ts*frt,'r');
%
subplot(424)
prt=ifft(pf.*conj(pf));
plot(ts*prt);
%---------------------------------------------------

subplot(425)
fprt=ifft(ff.*conj(pf));

plot(ts*fprt,'m')

%----------------------------------------
subplot(428)
hold off

fs=1/T;
sn=1/fs;

magpw=abs(ts*pf).^2;
mpw=circshift(magpw,[0,n]);
k=2*n;
mpw=mpw(1:k);
mpw=circshift(mpw,[0,n-16]);

a=floor(k/sn-4);
A=repmat(mpw,1,a+1);
B=reshape(A(1:(k+sn)*a),k+sn,a);
D=B(1:k,:);

hold off
plot(D,'b')
hold on
plot(sum(D,2),'k')

hold off
%--------------------------------------------------
subplot(427)
plot(D(:,9:12),'b')
hold on
plot(sum(D(:,9:12),2),'k')