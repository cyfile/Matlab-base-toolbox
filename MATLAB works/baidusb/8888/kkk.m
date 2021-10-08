% highpassvslowpass

m=zeros(1,2^8);
m(1:10)=1;
subplot(421)
plot(m)
subplot(422)
plot(abs(fft(m)))

m(1:10)=repmat([1,-1],1,5);
subplot(423)
plot(m)
subplot(424)
plot(abs(fft(m)))

v=8;
k=32;
n=linspace(-v,v,k);
c=repmat([-1,1],1,k/2);

ft=exp(-n.^2/2);
subplot(425)
plot(ft)
subplot(426)
plot(abs(fft(ft)))


ft=c.*ft;
subplot(427)
plot(ft)
subplot(428)
plot(abs(fft(ft)))