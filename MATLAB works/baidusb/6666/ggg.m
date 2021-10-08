% 量化器 Construct quantizer object to quantize data
a=5.4;
b=4.5; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数quantizer直接忽视参数的小数部分
q=quantizer([b a]) % 用b=4位二进制数表示数，其中小数位为a=5位
% 即 左起第一位(最高位)是符号位，第二位是2^-3位，
% 第四位是2^-5位
eps(q)==2^-floor(a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[c,d]=range(q); 
(d-c)/eps(q)==2^floor(b)-1
q.roundmode
quantize(q,[c-rand,c,c+eps(q)/2,c+eps(q)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num2bin(quantizer([5,0]),-16:16) % 有符号数 -16:15 的原码
% 反码，无符号数的补码: bitcmp