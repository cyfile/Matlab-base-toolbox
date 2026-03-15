
sigma = (-300:300)/150;
f = 2*pi*(0.01:0.01:20)';
res = sum(cos(f*sigma),1);
plot(sigma,res)
y = hilbert(res);
hold on
plot(sigma,abs(y))
%%
y = hilbert(x);
ff = ifft(fft(imag(y))./fft(real(y)));
plot(imag(y))
plot(cconv(ff,x,length(x)))
%%


return


%%
s = tf('s');
plant = 100/(s*(s + 1)*(s + 10));
% G = 1/(s+1)/(s+1)/(4/7*s-1);
H = 2*s+1;
% plant = feedback(G,H);
G = 1/(0.01*s+1)/(0.02*s+1);
G1 = G/s;
G2 = G1/s;
G3 = G2/s;
linearSystemAnalyzer('bode',plant,comp,plant*comp)
% controlSystemDesigner(G,1,H)
controlSystemDesigner('bode',plant)
% rlocus(sys)
% axis([-22 3 -15 15])
% plotoptions = nyquistoptions("cstprefs")
H = 100/(0.01*s+1)/(0.02*s+1)/(0.05*s+1)/s/s;
nyquistplot((0.03*s+1)*H)