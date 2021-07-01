% resample firls fir1  96.jpg
fs=400;
matObj = matfile('data_imp');
x=matObj.data_imp;
time=(0:length(x)-1)/fs;
subplot 411; hold on
plot(time,x);            
axis tight;title('原信号');
%%
psdobj = spectrum.periodogram('hamming');
hopts = psdopts(psdobj,x);  % Default options %
set(hopts,'Fs',fs,...
    'FreqPoints','User Defined',...
    'FrequencyVector',0:.01:5);  
subplot 224;hold on
psd(psdobj,x,hopts)
%%
fc=1;
[p,q]=rat(10*fc/fs);
%%
fs1=fs*p/q;                            % 求出降采样频率
x1=resample(x, p, q);                  % 信号降采样
time1=(0:length(x1)-1)/fs1;
subplot 423; hold on
plot(time1,x1);            % 下采样后的波形
axis tight;title('下采样后的信号');
%%
Fs=fs1; Fs2=Fs/2;                % 采样频率,奈奎斯特频率
fp1=1; fp2=2;                    % 通带频率
df=0.2;                          % 求取过渡带
M=2*Fs/df+14;                    % 凯泽窗长
%%
C = kaiserord([fp1-df,fp1,fp2,fp2+df],...
    [0 1 0],[0.01 0.05 0.01],fs1,...
    'cell');
b=fir1(C{:});
%b = fir1(M-1,[fp1-df/2,fp2+df/2]/Fs2,kaiser(M,3.5));
[h,w] = freqz(b,1,256,Fs);     % 求幅值响应
subplot(223);hold on;
plot(w,mag2db(abs(h)));
title('滤波器的幅值响应(dB)');
grid on;axis([0 Fs2 -100 10]);
%%
fls= firls(M-1,[0,fp1-df,fp1,fp2,fp2+df,Fs2]/Fs2,[0,0,1,1,0,0]);
%b= firls(M-1,[0,fp1,fp1,fp2,fp2,Fs2]/Fs2,[0,0,1,1,0,0]);
b=fls.*kaiser(M,3.5)'; 
[h,w] = freqz(b,1,256,Fs);     % 求幅值响应
plot(w,mag2db(abs(h)),'g');
%%
y1=conv(x1,b,'same');
subplot 423; plot(time1,y1,'r');

y1_f=filter(b,1,x1);
subplot 424; plot(time1,y1_f);
title('滤波器的滤出信号');

y=resample(y1, q, p);                  % 上采样恢复信号采样率
subplot 411; plot(time,y(1:length(x)),'r')            

subplot(224)
psd(psdobj,y,hopts)
lobj=findobj(gca,'type','line');
set(lobj(1),'color','r')