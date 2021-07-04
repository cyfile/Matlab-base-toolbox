% 算法系列（8篇）——第二篇 递归思想(matlab)
将十进制转化为二进制。

采用除2取余法，取余数为相应二进制数的最低位，然后再用商除以2得到次低位…….直到最后一次相除商为0时得到二进制的最高位，

比如(100)10=(1100100)2.

%%%%%%%%%%%%%%%%
function [b,c]=Untitled2(a)

b=R(a);
b=char(b+'0');
c=dec2bin(a);
function b=R(a)
 
r=rem(a,2);
s=fix(a/2);

if s==0
    b=r;
else
    b2=R(s);
    b=[b2,r];
end