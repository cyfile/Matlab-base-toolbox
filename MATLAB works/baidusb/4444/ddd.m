% Spectral estimation谱估计
b = fir1(1024, .5);%生成一个较好的频谱曲线（有较多且显著的峰值）
[d,p0] = lpc(b,7); %根据频谱曲线生成信号发生滤波器

N=8192;
u = sqrt(p0)*randn(N,1);%生成激励
x = filter(1,d,u);         %产生数据

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
xf=abs(fft(x));           %通过数据计算频谱
xf=xf(1:N/2);
plot(linspace(1,512,N/2),pow2db(xf.^2/N)) %计算能量谱密度

[d1,p1] = aryule(x,7);     %生成数据的ar模型
[H1,w1]=freqz(sqrt(p1),d1);
plot(mag2db(abs(H1)),'r','linewidth',2)  %根据模型求数据的能量谱密度
%或者 plot(pow2db(abs(H1).^2),'r','linewidth',2)

%plot(mag2db(abs(H1)/2/pi),'g','linewidth',2)  %根据模型求数据的功率谱密度

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=impz(1,d1,8);           %生成数据的ma模型
fvtool(1,d1,a1,1,a1,d1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x2 = filter(a1,1,u);
s = spectrum.periodogram;       %谱估计对象
%或者 s = spectrum.periodogram('hamming');
figure
subplot(2,1,1)
psd(s,x)  %功率谱密度
subplot(2,1,2)
psd(s,x2); %功率谱密度