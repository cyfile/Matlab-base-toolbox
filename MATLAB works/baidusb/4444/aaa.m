% firetruck siren 解析并生成消防车警笛
%%% 声音载入与初步分析
[Y,FS] = mp3read('Firetrucksiren.mp3');
%[Y,FS] = wavread('3240.wav');
%[Y,FS] = mp3read('074.mp3');
%wavwrite(Y(:,1),FS,'firetruck.wav')
% player = audioplayer(Y,FS);
% play(player)
%% 提取并初始化参数
y=Y(:,1);
N=size(y,1);
f=FS*5.5*2.6;
%% 提取兴趣段
n=0;
seg=y(n*f+1:min(n*f+f,N));
% player = audioplayer(seg,FS);
% play(player)
clear f n y Y
% % return
% % %% 时域概要
% % subplot(211)
% % plot(seg)
% % axis tight
% % subplot(212)
% % %spectrogram(seg,256,0,256,FS,'yaxis' )
% % [S,F,T,P]=spectrogram(seg,512,128,1024,FS,'yaxis' );
% % k=floor(length(F)/2);
% % surf(T,F(1:k),10*log10(abs(P(1:k,:))),'edgecolor','none');
% % axis tight;
% % view(0,90);
% % %% 频域概要
% % figure
% % subplot(122)
% % surf(F(1:k),T,10*log10(abs(P(1:k,:))'),'edgecolor','none');
% % axis tight;
% % view(0,90);
% % subplot(121)
% % segf=abs(fft(seg));
% % segf=segf(1:floor(length(seg)/4));
% % plot(segf)
% % %



%%% 解调，解析激励
%z = fmdemod(seg,500,FS,1000); %
z = fmdemod(seg,1000,FS,500); %
%%
figure('defaultAxesxtick',[],...
    'defaultAxesytick',[])
subplot(321);
plot(z);axis tight

subplot(323)
a=filter(hamming(100),1,z);
plot(a);axis tight

subplot(325)
%b=decimate(a,3*1000);
b = downsample(a,100);
plot(b);axis tight

subplot(322)
%c=filter(1/121,[1 -1/2 -1/6 -1/12 -1/20 -1/30 -1/42 -1/56 -1/72 -1/90],b);
c=medfilt1(b,51,5000);
c=medfilt1(c,51,5000);
plot(c);axis tight

subplot(324)
u=b(2504:4776);%3468
u=medfilt1(u,31,5000);%doc smooth
plot(u);axis tight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
subplot(326)

tindv=1:3468-2504;
v=u(tindv);
tv=tindv*100/FS;
tindw=3468-2504+1:4776-2504+1;
w=u(tindw);
tw=tindw*100/FS;

plot([tv,tw],u);axis tight;hold on

st='a*b^x+c';
ft = fittype(st);
opts = fitoptions( ft );
opts.Lower = [-inf 0 -inf];
opts.Upper = [inf 1 inf];
opts.Robust='Bisquare';
%opts.StartPoint = [-5 0.3238 -1 70];

ftv = fit(tv', v, ft, opts );
ftw = fit(tw', w, ft, opts );

Cv=num2cell(coeffvalues(ftv));
Cw=num2cell(coeffvalues(ftw));
th=eval(solve(subs(st,coeffnames(ft),Cv)-subs(st,coeffnames(ft),Cw)));
A=feval(ftv,th);

vv=feval(ftv,0-0.0104:1/FS:th);
ww=feval(ftw,th:1/FS:tw(end));

plot(ftv);plot(ftw)
plot([vv;ww;vv])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%z1 = pmdemod(seg,1500,FS,pi/2);

%z2 = amdemod(seg,750,FS);
% plot(z2)
% spectrogram(z3,512,128,1024,FS)
% z3 =  ssbmod(seg,1500,FS);
% plot(z3)



%%%%%%%%%%%%%%%
y = fmmod([vv;ww;vv;ww]/55,850,FS,750);
figure
subplot(211)
spectrogram(y,512,128,1024,FS)
subplot(212)
plot([vv;ww;vv;ww])
player = audioplayer(y,FS);
play(player)