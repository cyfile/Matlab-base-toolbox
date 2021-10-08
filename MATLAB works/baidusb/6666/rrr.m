% 两个表达式不同的函数仅相差一个常数
syms x

f=sin(x)/cos(x)^3 

ezplot(f)

intf1=int(f)

ezplot(diff(intf1))

intf2=tan(x)^2/2

figure

ezplot(diff(intf2))