% memo pad
% Initialize system parameters
Fs = 10000; Rs = 100; nSamps = Fs/Rs; rollOff = 0.5;
hMod = modem.pskmod(4, pi/4);   % QPSK modulator object
% Square root raised cosine filters
filtSpec = fdesign.pulseshaping(nSamps,'Square root raised cosine',...
    'Nsym,Beta',16,rollOff);
hTxFlt = design(filtSpec); hTxFlt.PersistentMemory = true;
hRxFlt = copy(hTxFlt); hTxFlt.Numerator = hTxFlt.Numerator*nSamps;

% Generate modulated and pulse shaped signal
frameLen = 1000;
msgData = randi([0 hMod.M-1],frameLen,1);
msgSymbols = modulate(hMod, msgData);
msgTx = hTxFlt.filter(upsample(msgSymbols, nSamps));

t = 0:1/Fs:50/Rs-1/Fs; idx = round(t*Fs+1);
hFig = figure; plot(t, real(msgTx(idx)));
title('Modulated, filtered in-phase signal');
xlabel('Time (sec)'); ylabel('Amplitude'); grid on;
%%%%%%%%%%%%%%%%%%%%%%%%5

phaseoffset=0;
cons=exp(1j*([0,pi/2,pi,3*pi/2]+phaseoffset));
frameLen = 10;
msgData=randi(4,[frameLen,3]);
msgSymbols=cons(msgData);

Fs = 10000; Rs = 100; nSamps = Fs/Rs;
fH=2*pi*Rs*(3:5);
kk=zeros(frameLen*nSamps,3);
for k=1:3
kk(:,k)=filter(exp(1j*fH(k)*(0:nSamps-1)/Fs),1,upsample(msgSymbols(:,k), nSamps));
end
plot(sum(real(kk),2))
plot(real(kk))