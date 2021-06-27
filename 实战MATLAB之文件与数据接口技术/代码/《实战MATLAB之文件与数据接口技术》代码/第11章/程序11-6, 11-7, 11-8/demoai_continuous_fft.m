%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 《实战MATLAB之文件与数据接口技术》附加程序
% 作  者：江泽林 刘维
% 出版社：北京航空航天大学出版社
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 程序 11-8 demoai_continuous_fft.m
function condition = demoai_continuous_fft(data,plotHandle)
lengthofData =length(data);
nPower2 = 2 ^ nextpow2(lengthofData);
                                % 不小于数据长度的最小的2的整数次幂
fs =8000;                     % 采样率
yDFT = fft(data,nPower2);  % FFT
freqRange = (0:nPower2-1) * (fs / nPower2);  % 频率范围
gfreq = freqRange(1:floor(nPower2 / 2));
                                % 实信号FFT具有共轭对称性，故只取一半
h = yDFT(1:floor(nPower2 / 2));
abs_h = abs(h);
threshold = 10;               % 频率检验阈值
set(plotHandle, 'ydata',abs_h,'xdata',gfreq); % 更新频谱图的数据
drawnow;                       % 更新频谱图
val = max(abs_h(gfreq > 2500 & gfreq < 3000));
                                 % 获取2500~3000频谱范围中的最大值
if (val > threshold)
    condition = 1;
else
    condition = 0;
end
end
