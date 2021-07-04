% plotwavelet

function plotwavelet

wn='haar';
[~,p,t] = wavefun(wn,6);
t=plotgrap(p,t,0,wn);

wn='db2';
[~,p,t] = wavefun(wn,6);
t=plotgrap(p,t,1,wn);

wn='morl';
[p,t]=wavefun(wn,6);
t=plotgrap(p,t,2,wn);

wn='meyr';
[~,p,t]=wavefun(wn,6);
t=plotgrap(p,t,3,wn);

 

function ot=plotgrap(p,t,c,wna)
fb=1/(t(2)-t(1))/2;
fs=1/(t(end)+t(2)-2*t(1));
n=length(t);

f=-fb:fs:fb;
if length(f)~=n
    f(end)=[];
end
ot=t-(t(1)+t(end))/2;

subplot(421+c*2)
plot(ot,p)

[LB,UB]=wavsupport(wna);
a=['[',num2str(LB),' ',num2str(UB),']'];

pa=[ones(1,n);cumprod(repmat(ot,5,1),1)]';
vm1=['[',num2str(p*pa,'%4.1f'),']'];
title([wna,'  support: ',a,'vanishing  moments: ',vm1])

subplot(422+c*2)
plot(f,fftshift(abs(fft(p))))
title(['N=',num2str(n)])
end

end