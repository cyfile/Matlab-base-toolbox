% matlab大幂指数取余
求mod(5^17555,27038)

程序一：迭代

function myrem=Untitled2(e,c)  
if (nargin == 0)  
    e=[5,17555];  
    c=27038;  
end  
a=e(1);  
b=e(2);  
      
      
k=floor(log(1e15)/log(a));  
disp(num2str(a^k))  
if k>=b  
    myrem=rem(a^b,c);  
    return
end  
      
aa=mod(a^k,c);  
bb=floor(b/k);  
      
tmp=rem(b,k);  
% bb*k+tmp==b  
cc=rem(a^tmp,c);  
% cc=rem(c2,c);  
      
      
m=Untitled2([aa,bb],c);  
myrem=rem(m*cc,c);
程序二：while循环

function lrem=Untitled3(a,c)  
if (nargin == 0)  
    a=[5,17555,1];  
    c=27038;  
end  
     
while a(1)~=0
a=simp(a,c);  
end  
lrem=a(3);  
     
     
function A=simp(S,C)  
% mod(5^17555,27038)  
% C=27038;  
%mod(a^b*c,C)  
a=S(1);  
b=S(2);  
c=S(3);  
     
k=floor(log(1e15)/log(a))  
a^k  
if k>=b  
    cc=rem(rem(a^b,C)*c,C);  
    aa=0;bb=1;  
    A=[aa,bb,cc];  
    return
end  
     
aa=mod(a^k,C);  
bb=floor(b/k);  
     
tmp=rem(b,k);  
% bb*k+tmp==b  
c2=rem(a^tmp,C);  
cc=rem(c2*c,C);  
     
A=[aa,bb,cc];
测试脚本

rem(1234^8,456)  
rem(rem(1234^4,456)^2,456)  
rem(rem(1234^2,456)^4,456)  
    
    
Untitled3([1234,8,1],456)  
Untitled2([1234,8],456)
 取余加上循环可以用来检验质数