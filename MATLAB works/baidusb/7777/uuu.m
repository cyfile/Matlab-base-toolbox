% discretewavelet
clear
clc
load noisbloc
s=noisbloc;
n=length(s);
subplot(421);plot(1:n,s);axis tight

[c,l]=wavedec(s,3,'db4');
subplot(422);plot(c);axis tight

ca0=appcoef(c,l,'db4',0);
subplot(421);title(num2str(norm(ca0-s)))
ca1=appcoef(c,l,'db4',1);
subplot(423);plot(ca1);axis tight
ca2=appcoef(c,l,'db4',2);
subplot(425);plot(ca2);axis tight
ca3=appcoef(c,l,'db4',3);
subplot(427);plot(ca3);axis tight

cd1=detcoef(c,l,1);
subplot(424);plot(cd1);axis tight
cd2=detcoef(c,l,2);
subplot(426);plot(cd2);axis tight
cd3=detcoef(c,l,3);
subplot(428);plot(cd3);axis tight

%%
figure

fdb4=upcoef('a',1,'db4',3);
pdb4=upcoef('d',1,'db4',3);
subplot(443);plot(fdb4)
subplot(444);plot(pdb4)


A3=wrcoef('a',c,l,'db4',3);
A32=upcoef('a',ca3,'db4',3);
length(A32)-length(A3)
2*length(fdb4)
D3=wrcoef('d',c,l,'db4',3);
subplot(427);plot(A3);axis tight
subplot(428);plot(D3);axis tight
A2=wrcoef('a',c,l,'db4',2);
D2=wrcoef('d',c,l,'db4',2);
subplot(425);plot(A2);axis tight
title(num2str(norm(A2-A3-D3)))
subplot(426);plot(D2);axis tight
A1=wrcoef('a',c,l,'db4',1);
D1=wrcoef('d',c,l,'db4',1);
subplot(423);plot(A1);axis tight
title(num2str(norm(A1-A2-D2)))
subplot(424);plot(D1);axis tight
A0=wrcoef('a',c,l,'db4',0);
subplot(421);plot(A1);axis tight
title([num2str(norm(A0-A1-D1)),'  ',num2str(norm(A0-s))])