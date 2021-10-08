function c=subfreq(a,b)
% b-a


tmp = zeros(size(b));
tmp(1: length(a)) = a ;
aabs = abs(fft(tmp));
bb = fft(b);
%%
r = [ 0 0 0 0 ];
tmp =  sum([ hankel(aabs,[aabs(end),r]), toeplitz( aabs ,[aabs(1),r]) ],2);
aind = tmp>4;
%plot([aabs tmp+0.5])
sum(aind)
bb(aind)=0;
c = ifft( bb );
%%
% bindex = round((aindex-1)*bn/an)+1;
% temp = zeros(size(bb));
% temp(bindex)=aa(aindex);

% figure
% plot([ abs(bb) ,(abs(aa)*bn/an +1)])

% c=ifft(bb-aa*bn/an);
% bb(abs(aa)>0.15)=0;
% c = ifft( bb );
% c=ifft(bb-aa);