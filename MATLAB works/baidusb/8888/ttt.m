% linearlayer716

clear
clc
close all
figure
n=100;
time=linspace(1,2.5,n);
x=sin(sin(time).*time*10);

ty=[x,0,2*x];
y=sum(reshape(ty(1:end-1),n,[])');

% p=con2seq(x);
% t=con2seq(y);

plot(time,x,'r',time,y,'k')
hold on

net=newlin([-3,3],1,[0 1],.1);
net.adaptparam.passes=5;

yaf=0;
ef=0;
for i=2:n
[net,ya,e,pf]=adapt(net,x(i),y(i));

plot([time(i-1),time(i)]',[yaf,ya]','-.',[time(i-1),time(i)]',[ef,e]','m')
yaf=ya;
ef=e;
end