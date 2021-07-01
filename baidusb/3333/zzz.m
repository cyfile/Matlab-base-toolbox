% Ambulance siren 解析救护车警笛
%%% 声音载入与初步分析
[Y,FS] = wavread('temp.wav');
%[Y,FS] = wavread('3225.wav');
y=Y(:,1);
N=size(y,1);
%spectrogram(y,256,0,2048,FS,'yaxis')
% player = audioplayer(y,FS);
% play(player)
%%
% % %% 时域概要
subplot(311)
[S,F,T,P]=spectrogram(y,512,0,2048,FS,'yaxis' );
k=floor(length(F)/2);
P=10*log10(abs(P(1:k,:)));
F=F(1:k,:);
n=1:length(T);

surf(n,F,P,'edgecolor','none');
axis tight;
view(0,90);
%%
%%%%%%%%%%%%%%%%%%%
pd=double(P>mean(max(P,[],2))+2);
subplot(312)
Z = linkage(pd','weighted','jaccard');%
%dendrogram(Z)
TT = cluster(Z,'maxclust',60);
plot(TT);axis tight

subplot(313)
Z = linkage(P','average','cosine');%'hamming'
%dendrogram(Z)
TT = cluster(Z,'maxclust',8);
plot(TT);axis tight
%%%%%%%%%%%%%%%%%%%%
%%
figure
n=50;
%sump4=sum(P,2)/size(P,2);
sump4=sum(P(:,12:130+n),2)/(119+n);
plot(F,sump4)

 



 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 

%%% 声音载入与初步分析
%[Y,FS] = wavread('temp.wav');
[Y,FS] = wavread('3225.wav');
y=Y(:,1);
N=size(y,1);
%spectrogram(y,256,0,2048,FS,'yaxis')
% player = audioplayer(y,FS);
% play(player)
%%
% % %% 时域概要
subplot(311)
[S,F,T,P]=spectrogram(y,256,0,2048,FS,'yaxis' );
k=floor(length(F)*3/5);
P=10*log10(abs(P(1:k,:)));
F=F(1:k,:);
n=1:length(T);

surf(n,F,P,'edgecolor','none');
axis tight;
view(0,90);
%%
%%%%%%%%%%%%%%%%%%%
pd=double(P>mean(max(P,[],2))+2);
subplot(312)
Z = linkage(pd','weighted','jaccard');%
%dendrogram(Z)
TT = cluster(Z,'maxclust',7);
plot(TT);axis tight

subplot(313)
Z = linkage(P','average','cosine');%'hamming'
%dendrogram(Z)
TT = cluster(Z,'maxclust',5);
plot(T,TT);axis tight
%%%%%%%%%%%%%%%%%%%%
%%
figure
sump4=sum(P,2)/size(P,2);
%nn=50;
%sump4=sum(P(:,12:130+n),2)/(119+n);
subplot(121)
plot(sump4,F);axis tight
subplot(122)
surf(n,F,P,'edgecolor','none');
axis tight;
view(0,90);



 %%%%%%%%

figure;subplot(211)
spectrogram(y,256,0,2048,FS)
subplot(212)
Hs=spectrum.periodogram('Hamming');
hopts = msspectrumopts(Hs,y);
set(hopts,'Fs',FS);
msspectrum(Hs,y,hopts)