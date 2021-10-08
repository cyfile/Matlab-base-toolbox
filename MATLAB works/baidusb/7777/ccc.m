% 这是从论坛http://www.ilovematlab.cn/thread-101925-1-45.html下载的m文件 ：
这是从论坛http://www.ilovematlab.cn/thread-101925-1-45.html下载的m文件 ：

% ct1
clear all,close all, clc;
    % 定义常数
    FL = 80;                % 帧长
    WL = 240;               % 窗长
    P = 10;                 % 预测系数个数
    [s,fs] = wavread('sunday_2.wav');             % 载入语音s
s = s/max(s); %归一化
    L = length(s);          % 读入语音长度
    FN = floor(L/FL)-2;     % 计算帧数
    
% 预测和重建滤波器
    exc = zeros(L,1);       % 激励信号（预测误差）
    zi_pre = zeros(P,1);    % 预测滤波器的状态
    s_rec = zeros(L,1);     % 重建语音
    zi_rec = zeros(P,1);
    
% 合成滤波器
    exc_syn = zeros(L,1);   % 合成的激励信号（脉冲串）
    s_syn = zeros(L,1);     % 合成语音
last_syn = 0;   %存储上一个（或多个）段的最后一个脉冲的下标
zi_syn = zeros(P,1);   % 合成滤波器的状态
    
% 变调不变速滤波器
    exc_syn_t = zeros(L,1);   % 合成的激励信号（脉冲串）
    s_syn_t = zeros(L,1);     % 合成语音
last_syn_t = 0;   %存储上一个（或多个）段的最后一个脉冲的下标
zi_syn_t = zeros(P,1);   % 合成滤波器的状态
    
% 变速不变调滤波器（假设速度减慢一倍）
v=.5;
    exc_syn_v = zeros(v\L,1);   % 合成的激励信号（脉冲串）
    s_syn_v = zeros(v\L,1);     % 合成语音
last_syn_v = 0;   %存储上一个（或多个）段的最后一个脉冲的下标
zi_syn_v = zeros(P,1);   % 合成滤波器的状态

    hw = hamming(WL);       % 汉明窗
    
    % 依次处理每帧语音
    for n = 3:FN
        % 计算预测系数（不需要掌握）
        s_w = s(n*FL-WL+1:n*FL).*hw;    %汉明窗加权后的语音
        [A E] = lpc(s_w, P);            %用线性预测法计算P个预测系数
                                        % A是预测系数，E会被用来计算合成激励的能量
        if n == 27
        % (3) 观察预测系统的零极点图
            zplane(1,A);
        end
        
        s_f = s((n-1)*FL+1:n*FL);       % 本帧语音，下面就要对它做处理
        % (4) 用filter函数s_f计算激励，注意保持滤波器状态
  [exc1,zi_pre] = filter(A,1,s_f,zi_pre);
        
        exc((n-1)*FL+1:n*FL) = exc1; %计算得到的激励
        % (5) 用filter函数和exc重建语音，注意保持滤波器状态
  [s_rec1,zi_rec] = filter(1,A,exc1,zi_rec);
        
        s_rec((n-1)*FL+1:n*FL) = s_rec1; %计算得到的重建语音
        % 注意下面只有在得到exc后才会计算正确
        s_Pitch = exc(n*FL-222:n*FL);
        PT = findpitch(s_Pitch);    % 计算基音周期PT（不要求掌握）
        G = sqrt(E*PT);           % 计算合成激励的能量G（不要求掌握）
          
  %方法3：本段激励只能修改本段长度
  tempn_syn = [1:n*FL-last_syn]';
  exc_syn1 = zeros(length(tempn_syn),1);
  exc_syn1(mod(tempn_syn,PT)==0) = G; %某一段算出的脉冲
  exc_syn1 = exc_syn1((n-1)*FL-last_syn+1:n*FL-last_syn);
  [s_syn1,zi_syn] = filter(1,A,exc_syn1,zi_syn);
  exc_syn((n-1)*FL+1:n*FL) =  exc_syn1;   %计算得到的合成激励
  s_syn((n-1)*FL+1:n*FL) = s_syn1;   %计算得到的合成语音
  last_syn = last_syn+PT*floor((n*FL-last_syn)/PT);
   
        % (11) 不改变基音周期和预测系数，将合成激励的长度增加一倍，再作为filter
        % 的输入得到新的合成语音，听一听是不是速度变慢了，但音调没有变。
  FL_v = floor(FL/v);
  tempn_syn_v = [1:n*FL_v-last_syn_v]';
  exc_syn1_v = zeros(length(tempn_syn_v),1);
  exc_syn1_v(mod(tempn_syn_v,PT)==0) = G; %某一段算出的脉冲
  exc_syn1_v = exc_syn1_v((n-1)*FL_v-last_syn_v+1:n*FL_v-last_syn_v);
  [s_syn1_v,zi_syn_v] = filter(1,A,exc_syn1_v,zi_syn_v);  
      last_syn_v = last_syn_v+PT*floor((n*FL_v-last_syn_v)/PT);   
        exc_syn_v((n-1)*FL_v+1:n*FL_v) =exc_syn1_v;  %计算得到的加长合成激励
        s_syn_v((n-1)*FL_v+1:n*FL_v) = s_syn1_v;   %计算得到的加长合成语音
        
        % (13) 将基音周期减小一半，将共振峰频率增加150Hz，重新合成语音，听听是啥感受～
  PT1 =floor(PT/2);   %减小基音周期
        poles = roots(A);
  deltaOMG = 150*2*pi/8000;
  for p=1:10   %增加共振峰频率，实轴上方的极点逆时针转，下方顺时针转
   if imag(poles(p))>0 poles(p) = poles(p)*exp(j*deltaOMG);
   elseif imag(poles(p))<0 poles(p) = poles(p)*exp(-j*deltaOMG);
   end
  end
  A1=poly(poles);
  if n==27
   figure;
   zplane(1,A1);
  end
  
  tempn_syn_t = [1:n*FL-last_syn_t]';
  exc_syn1_t = zeros(length(tempn_syn_t),1);
  exc_syn1_t(mod(tempn_syn_t,PT1)==0) = G; %某一段算出的脉冲
  exc_syn1_t = exc_syn1_t((n-1)*FL-last_syn_t+1:n*FL-last_syn_t);
  [s_syn1_t,zi_syn_t] = filter(1,A1,exc_syn1_t,zi_syn_t);
  exc_syn_t((n-1)*FL+1:n*FL) =  exc_syn1_t;   %计算得到的合成激励
  s_syn_t((n-1)*FL+1:n*FL) = s_syn1_t;   %计算得到的合成语音
  last_syn_t = last_syn_t+PT1*floor((n*FL-last_syn_t)/PT1);
        
    end
    % (6)  s ，exc 和 s_rec 的区别
figure;
subplot(3,1,1), plot(exc), xlabel('n (samples)'), ylabel('Amplitude'), title('激励信号');
subplot(3,1,2), plot(s), xlabel('n (samples)'), ylabel('Amplitude'), title('原语音信号');
subplot(3,1,3), plot(s_rec), xlabel('n (samples)'), ylabel('Amplitude'), title('重建语音信号');
figure;
subplot(3,1,1), plot(exc), xlabel('n (samples)'), ylabel('Amplitude'), title('激励信号'), XLim([15*FL+1,16*FL]);
subplot(3,1,2), plot(s), xlabel('n (samples)'), ylabel('Amplitude'), title('原语音信号'), XLim([15*FL+1,16*FL]);
subplot(3,1,3), plot(s_rec), xlabel('n (samples)'), ylabel('Amplitude'), title('重建语音信号'), XLim([15*FL+1,16*FL]);

sound(exc);
pause(2);
    sound(s);
    pause(2);
sound(s_rec);
pause(2);

  %原始语音与合成语音的差别
figure;
subplot(3,1,1), plot(exc_syn), xlabel('n (samples)'), ylabel('Amplitude'), title('合成激励信号');
subplot(3,1,2), plot(s), xlabel('n (samples)'), ylabel('Amplitude'), title('原语音信号');
subplot(3,1,3), plot(s_syn), xlabel('n (samples)'), ylabel('Amplitude'), title('合成语音信号');

sound(s);
    pause(2);
sound(s_syn);
pause(2);

%变速不变调
figure;
subplot(3,1,1), plot(exc_syn_v), xlabel('n (samples)'), ylabel('Amplitude'), title('合成慢速激励信号') ,XLim([0,length(exc_syn_v)]);
subplot(3,1,2), plot(s), xlabel('n (samples)'), ylabel('Amplitude'), title('原语音信号'), XLim([0,length(s)]);
subplot(3,1,3), plot(s_syn_v), xlabel('n (samples)'), ylabel('Amplitude'), title('合成慢速语音信号'), XLim([0,length(s_syn_v)]); 
sound(s);
    pause(2);
sound(s_syn_v);
pause(4);

   %变调不变速
figure;
subplot(3,1,1), plot(exc_syn_t), xlabel('n (samples)'), ylabel('Amplitude'), title('合成高调激励信号') ,XLim([0,length(exc_syn_t)]);
subplot(3,1,2), plot(s), xlabel('n (samples)'), ylabel('Amplitude'), title('原语音信号'), XLim([0,length(s)]);
subplot(3,1,3), plot(s_syn_t), xlabel('n (samples)'), ylabel('Amplitude'), title('合成高调语音信号'), XLim([0,length(s_syn_t)]); 
sound(s);
    pause(2);
sound(s_syn_t);