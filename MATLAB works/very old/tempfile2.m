%%复数幂
%%=========================================
%% 当k为整数时 exp(Z*k)=exp(Z)^k
Z=rand+10i*rand
log(exp(Z))
ki=randi(10);
%
exp(Z*ki),
exp(real(Z*ki))*(cos(imag(Z*ki))+i*sin(imag(Z*ki)))
%
exp(Z)^ki,% 当k为非整数时,计算这个要先算log(exp(Z))
exp(real(log(exp(Z))*ki))*(cos(imag(log(exp(Z))*ki))+i*sin(imag(log(exp(Z))*ki)))
exp(log(exp(Z))*ki),exp(log(exp(Z)))^ki
%%=========================================
%% 当k不整数,且imag(Z)不在区间[-pi pi]时 exp(Z*k)!=exp(Z)^k
Zb=rand+i*(10*rand+pi),
Zc=log(exp(Zb))%!=Zb
Zb-Zc,2*pi 
k=rand;
exp(Zb*k),exp(Zb)^k,%exp(Z*k)!=exp(Z)^k
%% ====================================
%% 复数取对数的算法
%%
exp(Zb),exp(real(Zb))*(cos(imag(Zb))+i*sin(imag(Zb)))
re=real(exp(Zb));
im=imag(exp(Zb));
M=hypot(re,im);
log(exp(Zb)),log(M) + 1i*atan2(im,re)
Zb
% For complex inputs z = x + 1i*y, exp calculates the complex exponential
% exp(x).*(cos(y) + 1i*sin(y)).
% For complex or negative inputs, log computes the complex logarithm
% log(abs(z)) + 1i*atan2(y,x).
% 因为atan2(y,x)的值域总在[-pi pi]之间
% 所以Zb的幅角不在这个区域时,log(exp(Zb))算出的幅角将和Zb相差2*n*pi
% 这个角度差,在k是整数时对于exp(Z)^k,exp(Z*k)的值并没有影响
% 但是在k为小数时,由于exp(Zb)取log算出的Zb2和Zb不同,
% Zb2,Zb它们都乘k后幅角并不一致(并不也相差2*n*pi)
% 进而exp(Z*k),exp(Z)^k不同
exp(Zb*k),exp(Zb)^k



