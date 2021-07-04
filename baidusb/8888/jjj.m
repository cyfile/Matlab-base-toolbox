% gaussfft


N=256;
v=sqrt(N*2*pi)/2;
% v=24;
figure1=figure;
t=linspace(-v,v,N);

T=2*v;
ts=t(2)-t(1);
ft=exp(-t.^2/2);

subplot(221)
plot(t,ft,'r')
title(['e^{-t^2/2}   L^1=',num2str(ts*sum(ft)),...
    '   L^2=',num2str(ts*ft*ft')])
xlabel(['t=n*ts  t\in[-T/2 T/2]  t=',...
    num2str(-v,'%4.1f'),':',num2str(ts,'%4.3f'),':',num2str(v,'%4.1f')]);
hold on
ef=fftshift(abs(fft(ft)));
plot(t,ef/max(ef))
ax=axis;
axis([-v,v,ax(3),ax(4)])
%-------------------------------------------------------------------
F=1/ts;
dw=1/T;
w=linspace(-F/2,F/2,N);

subplot(222)
fw=fftshift(abs(fft(ft)));
plot(w,fw)
title(['1/ts*{(2*\pi)^{0.5}}*e^{-(2*\pi*f)^2/2}   L^1=',num2str(dw*sum(fw)),...
    '   L^2=',num2str(dw*fw*fw')])
xlabel(['f(Hz)=k*df f\in[-F/2 F/2]  f=',...
    num2str(-F/2,'%4.1f'),':',num2str(dw,'%4.3f'),':',num2str(F/2,'%4.1f')]);


subplot(224)
nfw=ts*fw;
plot(w,nfw)
title(['{(2*\pi)^{0.5}}*e^{-(2*\pi*f)^2/2}   L^1=',...
    num2str(dw*sum(nfw)),...
    '   L^2=',num2str(dw*nfw*nfw')])
xlabel(['f=k(Hz)*df f\in[-F/2 F/2]  \omega=',...
    num2str(-F*pi,'%4.1f'),':',num2str(2*pi*dw,'%4.3f'),':',num2str(F*pi,'%4.1f')]);

subplot(223)
Fw=F*pi;
f=w*2*pi;
df=dw*2*pi;
nff=nfw;
plot(f,nff)
title(['{(2*\pi)^{0.5}}*e^{-\omega^2/2}   L^1=',...
    num2str(df*sum(nff)),...
    '   L^2=',num2str(df*nff*nff')])
xlabel(['\omega(rad)=k*dw \omega\in[-Fw/2 Fw/2]  \omega=',...
    num2str(-Fw,'%4.1f'),':',num2str(pi*2*dw,'%4.3f'),':',num2str(Fw,'%4.1f')]);

 

% Create textbox
annotation(figure1,'textbox',...
    [0.6 0.7 0.07 0.07],...
    'String',{'f(0)=\Sigmaf(n)'},...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.7 0.7 0.1 0.06],...
    'String',{'f(0)=\intf(t)\approxts*\Sigmaf(n)'},...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.3457265625 0.73094867807154 0.1152109375 0.125972006220839],...
    'String',{'T=(N-1)*ts','ts=T/(N-1)','N=T/ts+1','t=n*ts'},...
    'FitBoxToText','off');

% Create textbox
annotation(figure1,'textbox',...
    [0.436546875 0.28 0.1406015625 0.194401244167963],...
    'String',{'1/T=fs','1/ts=F','','T/N=2*\pi/T(ts=2*pi*fs)','时两线重叠'},...
    'FitBoxToText','off');

% Create textarrow
annotation(figure1,'textarrow',[0.4 0.5947265625],...
    [0.638191290824261 0.63452566096423],'TextEdgeColor','none',...
    'String',{'fft'});

% Create textarrow
annotation(figure1,'textarrow',[0.7548828125 0.75],...
    [0.67551632970451 0.354587869362364],'TextEdgeColor','none','String',{'*ts'});
