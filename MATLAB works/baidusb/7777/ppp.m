% swtandiswt
load noisbloc; s = noisbloc;
subplot(411);plot(s)
% Perform SWT decomposition at level 3 of s using db1.
swc = swt(s,3,'db1');
% Second usage.
[swa,swd] = swt(s,3,'db1');
for n=1:3
    subplot(421+2*n);plot(swa(n,:))
    subplot(422+2*n);plot(swd(n,:))
end


figure
mzero=zeros(size(swd));
D=mzero;
A=mzero;
A(3,:)=iswt(swa,mzero,'db1');
for n=1:3
    swcfs=mzero;
    swcfs(n,:)=swd(n,:);
    D(n,:)=iswt(mzero,swcfs,'db1');
end

for n=1:3
   
    subplot(422+2*n);plot(D(n,:))
end

for n=3:-1:2
   
    subplot(421+2*n);plot(A(n,:))
   
    A(n-1,:)=A(n,:)+D(n,:);
end
subplot(423);plot(A(1,:))

ss=A(1,:)+D(1,:);
subplot(411);plot(ss)
norm(s-ss)