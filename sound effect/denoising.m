x=y(min(a):median(a),1);
xn = y([median(a):max(a)],1);
Fs=44100;

%% STFT parameters
Nfft=1024;
Nwin=768; 
overlap=512; 
win = sqrt(hanning(Nwin,"periodic"));

%%  Estimate SNR
[~,~,~,Pn]= spectrogram(xn,win,overlap,Nfft); 
[Sx,~,~,Px] = spectrogram(x,win,overlap,Nfft); 
%%
% A=quantile(Pn,0.35,2).*quantile(Pn,0.65,2)./quantile(Pn,0.2,2)./quantile(Pn,0.8,2);
% noise_A= A.*quantile(Pn,0.5,2);
 noise_B= 2*quantile(Pn,0.35,2);
% noise_C= mean(Pn,2);
%noise_D= median(Pn,2);

noise_r= min( noise_B./Px  , 1 );

fa = db2mag(-3*[20:-1:0,1:20]);
fa = fa/sum(fa);
fb= db2mag(-12*[5:-1:0,1:5]);
fb = fb/sum(fb);
%noise_r = conv2(fb,fa,noise_r,'same');
noise_r = conv2(noise_r,fa,'same');
%noise_r = conv2(noise_r,fb','same');

beta1=0.5;
beta2=0.4;
lambda=logspace(log10(1.1),log10(4.5),Nfft/2+1)'; 
mask=max( 1-lambda.*noise_r.^beta1 , 0).^beta2;
%mask(Nwin/2-30:end,:)=0;
STFT=mask.*Sx;

%%  Compute inverse STFT and overlapp add
[Ft,Nt] = size(STFT);
Xtemp = ifft([STFT;conj(STFT(Ft-1:-1:2,:))] );
Xs = Xtemp(1:Nwin,:).*win;

hop = Nwin - overlap;
out=zeros((Nt-1)*hop + Nwin,1);
for index=1:Nt 
    ind=(index-1)*hop ;
    out(ind+1:ind+Nwin)= out(ind+1:ind+Nwin)+Xs(:,index);
end

display(['new out ' num2str(randi(999))])
return

%% -----------------    Listen results   ------------------------------------
%%
soundsc(xn,Fs);
soundsc(x,Fs);
soundsc(out,Fs);
figure,plot(out)
y=out;
%% -----------------    Display Figure   ------------------------------------      
%% show spectrogram
figure
subplot(211)
spectrogram(x,win,overlap,Nfft,Fs); 
colorbar(gca,'off')
subplot(212)
spectrogram(out,win,overlap,Nfft,Fs);
colorbar(gca,'off')
