% 算法系列（8篇）——第一篇 递推思想(matlab)
a=1; 
b=0; 
c=0; 
   
for k=1:12
disp(num2str(a+b+c)) 
c=c+b; 
b=a; 
a=c; 
end 
   
r0=[1;0;0]; 
a=[0,1,1;1,0,0;0,1,1]; 
for k=1:12
    disp(num2str(sum(r0))) 
r0=a*r0; 
end 
   
% sys = ss(a,zeros(3),ones(1,3),zeros(1,3),-1)  
sys = ss(a,[],ones(1,3),[],-1); 
[y,t]=initial(sys,[1,0,0]',0:11) 
   
b=zeros(3); 
b(2)=1;b(6)=1;b(9)=1; 
sys = ss(a,b,ones(1,3),ones(1,3),-1); 
u=zeros(3,12); 
u(1)=1; 
[y,t] =lsim(sys,u,0:11,[0,0,0]') 
%=================================
   
m=0; 
r=1+0.0171/12; 
for k=47:-1:1
    m=(m+3000)/r; 
    disp(num2str([k,m])) 
end