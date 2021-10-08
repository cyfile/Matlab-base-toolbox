% Change audio speed and pitch语音变速变调
function ct2
% 定义常数
FL = 80;                % 帧长
WL = 240;               % 窗长
P = 10;                 % 预测系数个数
hw = hamming(WL);       % 汉明窗
%%%%%%
[s,Fs] = wavread('sunday_2.wav');             % 载入语音s
load('mtlb.mat');
s=mtlb;
s=buffer(s,FL);
[~,FN] = size(s);        % 计算帧数

% 预测和重建滤波器
exc = zeros(FL,FN);       % 激励信号（预测误差）
s_rec = exc;              % 重建语音
zi_pre = zeros(P,1);      % 预测滤波器的状态
zi_rec = zeros(P,1);      % 重建滤波器的状态

% 合成滤波器
exc_syn =exc;             % 合成的激励信号（脉冲串）
s_syn = exc;              % 合成语音
last_syn = 0;             % 存储上一个帧的最后一个脉冲在下一帧结束的位置
zi_syn = zeros(P,1);      % 合成滤波器的状态

% 变速不变调滤波器
FL_v = 2*FL;              % 假设速度减慢一倍
exc_syn_v = zeros(FL_v,FN);  % 合成的激励信号
s_syn_v = exc_syn_v;      % 合成语音
last_syn_v = 0;
zi_syn_v = zeros(P,1);    % 合成滤波器的状态

% 变调不变速滤波器
exc_syn_t = zeros(FL,FN);
s_syn_t = exc_syn_t;
last_syn_t = 0;
zi_syn_t = zeros(P,1);

% 记录中间参数
A_c=zeros(P+1,FN);    %记录每帧提取的预测系数
PT_c=zeros(1,FN);     %记录每帧提取的基音周期

% 依次处理每帧语音
for n = 2:FN-1
    % 计算预测系数（建立声道的系统模型）
    s_w = s(:,n-1:n+1);                    %汉明窗加权后的语音
    [A E] = lpc(s_w(:).*hw, P);            %用线性预测法计算P个预测系数
    E=E*WL/sum(hw);
    % A是预测系数，E会被用来计算合成激励的能量
    A_c(:,n)=A;  % -----------------------
   
    % 提取激励，并用激励重建语音
    [exc(:,n),zi_pre] = filter(A,1,s(:,n),zi_pre);% 计算激励
    [s_rec(:,n),zi_rec] = filter(1,A,exc(:,n),zi_rec);% 重建语音
   
    % 提取基音周期，用于人工合成激励
    %s_Pitch = exc(:,n-1:n+1);
    PT = findpitch(s_w(:))-1;    % 计算基音周期PT（不要求掌握）
    PT_c(:,n)=PT; % -------------------------
    G = sqrt(E*PT);           % 计算合成激励的能量G（不要求掌握）
   
    % 合成语音
    tmpind=last_syn+1:PT:FL;
    exc_syn(tmpind,n) = G;        % 人工生成本帧激励
    last_syn=mod(PT+tmpind(end)-FL,FL);
    [s_syn(:,n),zi_syn] = filter(1,A,exc_syn(:,n),zi_syn); %通过人造激励合成语音
   
    % 合成速度慢，但音调不变的语音。
    tmpind=last_syn_v+1:PT:FL_v;   % （不改变基音周期和预测系数，将合成激励的长度增加一倍）
    exc_syn_v(tmpind,n) = G;       % 人工生成本帧激励
    last_syn_v=mod(PT+tmpind(end)-FL_v,FL_v);
    [s_syn_v(:,n),zi_syn_v] = filter(1,A,exc_syn_v(:,n),zi_syn_v);
   
    % 合成变调不变速的语音
    poles = roots(A);
    deltaOMG = 150*2*pi/8000; % 将共振峰频率增加150Hz
    A1=poly(poles.*exp(sign(imag(poles))*1j*deltaOMG)); %生成新的声道模型
   
    PT1 =floor(PT/2);   % 将基音周期减小一半
    tmpind=last_syn_t+1:PT1:FL;
    exc_syn_t(tmpind,n) = G; % 人工生成本帧激励
    last_syn_t=mod(PT1+tmpind(end)-FL,FL);
    [s_syn_t(:,n),zi_syn_t] = filter(1,A1,exc_syn_t(:,n),zi_syn_t);
   
end

%return
xx=reshape(1:FL*FN,FL,FN);
splot(s,exc,s_rec,xx,'重建',Fs)
splot(s,exc_syn,s_syn,xx,'合成',Fs)
xx2=reshape(1:FL_v*FN,FL_v,FN);
splot(s,exc_syn_v,s_syn_v,xx2,'合成慢速',Fs)
splot(s,exc_syn_t,s_syn_t,xx,'合成高调',Fs)

function splot(s,ex,re,x,str,Fs)
figure;
ax(3)=subplot(3,1,1);
plot(s(:));  title('原语音信号')
ax(2)=subplot(3,1,2);
plot(x,ex);  title([str,'激励信号'])
ax(1)=subplot(3,1,3);
plot(re(:));  title([str,'语音信号'])
linkaxes(ax,'xy')

sound(s(:),Fs);
sound(ex(:),Fs);
sound(re(:),Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 

%%%%%%%%%%%%%%%%%%%%%

function ct3
% 定义常数
FL = 80;                % 帧长
WL = 240;               % 窗长
P = 10;                 % 预测系数个数
hw = hamming(WL);       % 汉明窗
%%%%%%
[sl,Fs] = wavread('sunday_2.wav');             % 载入语音s
% load('mtlb.mat');
% sl=mtlb;
s=buffer(sl,FL);
[~,FN] = size(s);        % 计算帧数

% 预测和重建滤波器
exc = zeros(FL,FN);       % 激励信号（预测误差）
s_rec = exc;              % 重建语音
zi_pre = zeros(P,1);      % 预测滤波器的状态
zi_rec = zeros(P,1);      % 重建滤波器的状态

% 合成滤波器
exc_syn =exc;             % 合成的激励信号（脉冲串）
s_syn = exc;              % 合成语音
last_syn = [];             % 存储上一个帧的最后一个脉冲在下一帧结束的位置
zi_syn = zeros(P,1);      % 合成滤波器的状态

% 变速不变调滤波器
FL_v = 2*FL;              % 假设速度减慢一倍
exc_syn_v = zeros(FL_v,FN);  % 合成的激励信号
s_syn_v = exc_syn_v;      % 合成语音
last_syn_v = [];
zi_syn_v = zeros(P,1);    % 合成滤波器的状态

% 变调不变速滤波器
exc_syn_t = zeros(FL,FN);
s_syn_t = exc_syn_t;
last_syn_t = [];
zi_syn_t = zeros(P,1);

% 记录中间参数
A=zeros(P+1,FN);    %记录每帧提取的预测系数
E=zeros(1,FN);
PT_sf=zeros(1,FN);
PT_rf=zeros(1,FN);     %记录每帧提取的基音周期

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[S,F,T,Psd]=spectrogram(sl,240,160,2048,1);
Pe=pow2db(abs(Psd));
figure;surf(T,F*2048,Pe,'edgecolor','none')
% figure;surf(T,F(1:200)*2048,Pe(1:200,:),'edgecolor','none')
axis tight;
view(0,90);
xlabel('Time'); ylabel('sample');

[w,ind]=max(bsxfun(@minus,Pe(1:200,:),1.03.^(1:200)'));
PT_sf=round(2048./ind);
pind=w<max(w)-25; %能量衰减20分贝的帧
PT_sf(pind)=FL-1; %基音周期置为帧长
figure;hold on;
plot(PT_sf,'r')

% 依次处理每帧语音
for n = 2:FN-1
    % 计算预测系数（建立声道的系统模型）
    s_f = s(:,n-1:n+1);                    %汉明窗加权后的语音
    [A(:,n) Et] = lpc(s_f(:).*hw, P);            %用线性预测法计算P个预测系数
    E(n)=Et*WL/sum(hw);
    % A是预测系数，E会被用来计算合成激励的能量
   
    % 提取激励，并用激励重建语音
    [exc(:,n),zi_pre] = filter(A(:,n),1,s(:,n),zi_pre);% 计算激励
    [s_rec(:,n),zi_rec] = filter(1,A(:,n),exc(:,n),zi_rec);% 重建语音
end

for n = 2:FN-1
    ex_f=exc(:,n-1:n+1);
    ex_f=ex_f(:);
    % 提取基音周期，用于人工合成激励
 
    R=xcorr(ex_f,1.5*FL);
    Rh=filter(hamming(16),1,R(1.5*FL+1:end));
    [~,PT]=findpeaks(Rh(9:end),'s','descend','n',1);
    PT_rf(:,n)=PT;
 
    G = sqrt(E(n)*PT);           % 计算合成激励的能量G（不要求掌握）
   
    [~,m]=findpeaks(ex_f(81:160),'s','descend','n',1);
    if isempty(m),m=121;end
    m=80+m;
    a=ceil(PT/2)-1;
    b=floor(PT/2);
    excf=[ex_f(m-b:m+a)];
    excfh=excf(1+mod(b,2):2:end);
    % 合成语音
    %n
    kt=ceil((FL-length(last_syn))/PT);
    GG=[last_syn;repmat(excf,kt,1)];
    exc_syn(:,n) = GG(1:80);        % 人工生成本帧激励
   
    last_syn=GG(81:end);
    %if length(exc_syn)>80,n,end
    [s_syn(:,n),zi_syn] = filter(1,A(:,n),exc_syn(:,n),zi_syn); %通过人造激励合成语音
   
    % 合成速度慢，但音调不变的语音。
    kt=ceil((FL_v-length(last_syn_v))/PT);   % （不改变基音周期和预测系数，将合成激励的长度增加一倍）
    GG=[last_syn_v;repmat(excf,kt,1)];
    exc_syn_v(:,n) = GG(1:160); % 人工生成本帧激励
    last_syn_v=GG(161:end);
    [s_syn_v(:,n),zi_syn_v] = filter(1,A(:,n),exc_syn_v(:,n),zi_syn_v);
   
    % 合成变调不变速的语音
    poles = roots(A(:,n));
    deltaOMG = 150*2*pi/8000; % 将共振峰频率增加150Hz
    A1=poly(poles.*exp(sign(imag(poles))*1j*deltaOMG)); %生成新的声道模型
   
    PT1 =length(excfh);   % 将基音周期减小一半
    kt=ceil((FL-length(last_syn_t))/PT1);
    GG=[last_syn_t;repmat(excfh,kt,1)];
    exc_syn_t(:,n) = GG(1:80); % 人工生成本帧激励
    last_syn_t=GG(81:end);
    [s_syn_t(:,n),zi_syn_t] = filter(1,A1,exc_syn_t(:,n),zi_syn_t);
   
end

plot(PT_rf);title('受频域分辨率的影响，70到80帧的精度很差')
xlabel('提高精度可以增加短时傅立叶变换的样点数目（当前是2048）')


%return
xx=reshape(1:FL*FN,FL,FN);
splot(s,exc,s_rec,xx,'重建',Fs)
splot(s,exc_syn,s_syn,xx,'合成',Fs)

xx2=reshape(1:FL_v*FN,FL_v,FN);
splot(s,exc_syn_v,s_syn_v,xx2,'合成慢速',Fs)
splot(s,exc_syn_t,s_syn_t,xx,'合成高调',Fs)

function splot(s,ex,re,x,str,Fs)
figure;
ax(3)=subplot(3,1,1);
plot(s(:));  title('原语音信号')
ax(2)=subplot(3,1,2);
plot(x,ex);  title([str,'激励信号'])
ax(1)=subplot(3,1,3);
plot(re(:));  title([str,'语音信号'])
linkaxes(ax,'xy')

sound(s(:),Fs);
sound(ex(:),Fs);
sound(re(:),Fs);