% db4
iter = 8;
wav = 'db4';

% Compute approximations of the wavelet function using the
% cascade algorithm.
for i = 1:iter
    [phi,psi,xval] = wavefun(wav,i);
    [~,ind]=max(psi);
    l=length(xval);
    plot(xval-xval(ind),psi);
    pause(1)
    hold on
end
title(['Approximations of the wavelet ',wav, ...
       ' for 1 to ',num2str(iter),' iterations']);