% dwtandidwt
s = 2 + kron(ones(1,8),[1 -1]) + ...
    ((1:16).^2)/32 + 0.2*randn(1,16);
subplot(311);hold on; plot(s); title('Original signal');


[ca,cd] = dwt(s,'haar');
subplot(323);hold on; plot(ca); title('Approx. coef. for haar');
subplot(324);hold on; plot(cd); title('Detail coef. for haar');


[Lo_D,Hi_D] = wfilters('haar','d');
[ca1,cd1] = dwt(s,Lo_D,Hi_D);
subplot(323); plot(ca1,'bo');
subplot(324); plot(cd1,'bo');

[Lo_R,Hi_R] = wfilters('haar','r');
ss=idwt(ca,cd,Lo_R,Hi_R);
subplot(311); plot(ss,'bo')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
ua=upcoef('a',ca,Lo_R,Hi_R,1);
ud=upcoef('d',cd,Lo_R,Hi_R,1);
subplot(311); plot(ua,':g');
subplot(311); plot(ud,':m');
subplot(311); plot(ua+ud,'sb');


ua1=conv(dyadup(ca,0),Lo_R);
ud1=conv(dyadup(cd,0),Hi_R);
subplot(311); plot(ua1,'og');
subplot(311); plot(ud1,'om');


f=idwt(1,0,Lo_R,Hi_R);
p=idwt(0,1,'haar');
m=length(ca);
for n=1:m
    UA2(n,2*n:(2*n+length(f)-1))=f.*ca(n);
end
ua2=sum(UA2);
subplot(311); plot(ua2(2:end),'*g');

ud2=filter(Hi_R,1,[dyadup(cd,0),0]);
subplot(311); plot(ud2,'*m');

%%
%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%
[f,p,t] = wavefun('haar',1)
subplot(325); hold on; stem(t,f,'sg');
subplot(325); hold on; stem(t,p,'*m');
%%%%%%%%%%%%%%%%%%%%
f=idwt(1,0,Lo_R,Hi_R);
p=idwt(0,1,'haar');

subplot(326); hold on; stem(f,'gs');
subplot(326); stem(p,'*m');