% Police car Fire truck and Ambulance siren生成各种警笛的叫声
function siren
%
FS=22050;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Police car and Fire truck siren %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=@(n) 7/5-12/5*exp(linspace(0,log(1/6),n));
u=@(n) linspace(1,-1,n);
%% ----- 1,Police car siren ----------
k=round(FS/9);
w=[v(k),u(2*k)];

s=repmat(w,1,10);
svco = vco(s,[600 1800],FS);

subplot(6,4,1:3)
plot(s),axis tight
subplot(6,4,5:7)
plotspt(svco,FS,1/4)
player = audioplayer(svco,FS);
playblocking(player)
%% ----- 2,Fire truck siren -----------
k=3*FS;
w=[v(round(k*0.618)),u(k)];

s=repmat(w,1,3);
sfm = fmmod(s,1200,FS,600);

subplot(6,4,9:11)
plot(s),axis tight
subplot(6,4,13:15)
plotspt(sfm,FS,1/4)
player = audioplayer(sfm,FS);
playblocking(player)
%% ----- 3,Mixed siren -----------
k=FS;%3*FS;
w=[v(round(4*k)),u(2*k)];

s=repmat(w,1,3);
smod=modulate(s,1200,FS,'fm',(1200/FS)*2*pi/2);

subplot(6,4,17:19)
plot(s),axis tight
subplot(6,4,21:23)
plotspt(smod,FS,1/4)
player = audioplayer(smod,FS);
playblocking(player)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ambulance siren %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=@(f,k) sin(2*pi*f/FS*(0:k*FS));
%% --------siren1-----------
n1=[1,3,5,7,8,9]';%频率系数
n2=[1,3,5,6,7]';%频率系数
a1=[1,1,1,1,1,1];%幅度系数
a2=[1,1,1,1,1];%幅度系数
L=122*24;%基准频率
w=[a1*v(L/8*n1,0.7)/sum(a1),a2*v(L/6*n2,0.7)/sum(a2)];
s=repmat(w,1,4);

subplot(6,4,[4,8,12])
plotspt(w,FS,1/3)
player = audioplayer(s,FS);
playblocking(player)
%% -----------siren2------------
n1=[1,2,3,4,5]';%频率系数
n2=[1,2,3,4,5,6]';%频率系数
a1=[8,.6,.6,1.8,1.8];%幅度系数
a2=[5.5,2,.6,.6,2,2];%幅度系数
L2=415;L1=560;%基准频率
w=[a1*v(L1*n1,0.7)/sum(a1),a2*v(L2*n2,0.5)/sum(a2)];
s=repmat(w,1,4);

subplot(6,4,[16,20,24])
plotspt(w,FS,1/3)
player = audioplayer(s,FS);
playblocking(player)

function plotspt(seg,FS,scale)
%
[S,F,T,P]=spectrogram(seg,512,128,1024,FS,'yaxis');
k=floor(length(F)*scale);
surf(T,F(1:k),10*log10(abs(P(1:k,:))),'edgecolor','none');
axis tight;
view(0,90);