% 音阶检测gamut ? detection
%%% 声音载入与初步分析
[Y,FS] = wavread('me.wav');
Y=Y(:,1);
N=size(Y,1);
FL=2^nextpow2(2*FS/100);%framelen=包含至少两个最低频成分的周期
% player = audioplayer(Y,FS);
% play(player)
%% 时域概要
[S,F,T,P]=spectrogram(Y,FL,FL/8,2048,FS,'yaxis');
k=floor(length(F)*2e3/(FS/2));%观察2千(2e3)Hz内的频谱
P=10*log10(abs(P(1:k,:)));
F=F(1:k,:);
n=1:length(T);

subplot(211)
surf(n,F,P,'edgecolor','none');
axis tight;view(0,90);
xlabel('n of frame'); ylabel('frequence(Hz)');
%% 低通滤波，并加权衰减后的语音信号
% 输出 fy
wn=round(FS/1e3);%估计窗长
fy=filter(hamming(wn,'symmetric'),1,Y);

[S,F,T,P]=spectrogram(fy,FL,FL/8,2048,FS,'yaxis');
k=floor(length(F)*2e3/(FS/2));%观察2千(2e3)Hz内的频谱
P=10*log10(abs(P(1:k,:)));
F=F(1:k,:);
n=1:length(T);

subplot(212)
surf(n,F,P,'edgecolor','none');
axis tight;view(0,90);
xlabel('n of frame'); ylabel('frequence(Hz)');
%% Spectrogram Interactive Tool
%specgramdemo(decimate(fy,10),FS/10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 分帧求取基音周期
%输出 C ， peakpoint
fyframe=buffer(fy,FL,FL/8);

mak=1;
loop=size(fyframe,2);
peakpoint=zeros(mak,loop);
C=zeros(FL,loop);
for k=1:loop
    c=xcorr(fyframe(:,k));
    C(:,k)=c(FL:end);
    %plot(C(:,125))
    [~,pp]=findpeaks(C(:,k),'s','descend','N',mak);
    peakpoint(1:length(pp),k)=sort(pp);
end

figure
subplot(211)
surf(bsxfun(@rdivide,C,C(1,:)),'edgecolor','none');
axis tight;view(0,90);
xlabel('n of frame'); ylabel('R(x)');
%% 通过基音的连续性提取有效的基音片段
%输出 note
subplot(413)
plot(peakpoint);% 原始提取的基音周期
axis tight;hold on

pp=peakpoint;
dpind=abs(diff(pp))>40;%plot(diff(peakpoint));
pp(dpind)=0;
dpind=abs(diff(pp))>40;%plot(diff(peakpoint));
pp([true,dpind])=0;
plot(pp,'g')% 粗略提取有效的基音片段2-1
note = medfilt1(pp,11);
plot(note,'r')% 粗略提取有效的基音片段2-2
%% 通过功率分布分割各个音符所在的基音片段
%输出 notep
subplot(414);hold off
pow=C(1,:)/max(C(1,:))*2;
plot(pow);
axis tight;hold on
notep = sign(pow-0.1);
plot(notep,'g')
plot([313,313],[-1,2],'m')
notep(313)=-1;%人工调整
notep = conv(notep,[1,1,1,1,1],'same')>4.9;
plot(notep,'r')
%% 给不同的音符片段数据分配标签
%输出lab
pp=diff(notep);
pp(pp<0)=0;
lab=[0,cumsum(pp)];
lab(notep==0)=0;
lab(note<100)=0;

n=1:length(lab);
figure;
subplot(311)
plotyy(n,note,n,notep)
subplot(312)
plot(lab,'r','linewidth',2)
hold on
%% 算出各个音符基音片段的基音周期，并根据基音频率拟合
not=accumarray(lab'+1,note,[],@(x)mean(x));
not=FS./not(2:end);
no=[1,3,5,6,8,10,12,13];
subplot(313)
plot(no,not,'o')

%k=2^(1/12);
st='a*2^(x/12)';
ft = fittype(st);
ftv = fit(no',not,ft, 'StartPoint', 107);
hold on
plot(ftv);
h=findobj(gcf,'Tag','legend');
set(h,'loca','NorthWest')

%% 聚类
subplot(312)
pd=bsxfun(@gt,C,max(C,[],1)/2);
Z = linkage(double(pd)','weighted','hamming');%
%dendrogram(Z)
TT = cluster(Z,'maxclust',20);
plot(TT,':y');axis tight

Z = linkage(C','average','cosine');%
%dendrogram(Z)
TT = cluster(Z,'maxclust',20);
plot(TT,':c');axis tight
%%%%%%%%%%%%%%%%%%%%