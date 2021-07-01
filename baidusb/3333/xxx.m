% First-Order discrete-time system一阶离散系统 continuous-
%% 生成激励1
FS=200;%抽样频率
T=5;f=1/T; %一个周期的时间


%%%%%%%%%%%%%%%%%%%%%
n=5;%n个周期
t=(0:1/FS:n*T)';
x=square(2*pi*f*t,38.2)+1;
subplot(311)
plot(t,x)
ylim([-3,3])
%%%%%%%%%%%%%%
NT=FS*T;
tT=t(1:NT);
%% 生成激励
%系统函数为z/(z-a),时域序列为a^n*U(n)
%输入是A*z/(z-1),A是方波的幅度
%% a1
subplot(312);hold on
a1=1;
C=a1.^((NT:-1:1)-1);
plot(tT,C,'c')
x1=x/2-0.382;%让上下两部分面积相等，保证拐点在0点
plot(t,x1,'r');
y1=filter(1,[1,-a1],x1);%这实际上是在积分
y11=y1/(NT*.382)/(1-.382);
plot(t,y11,'m')
%% a2
subplot(313);hold on
a2=(1/2)^(1/ceil(NT*0.382));%通过半衰期(N/2/0.382)算a
%一个周期为NT，(NT/0.382)是一个周期的中的一点，
%以此点作为半衰点，有a^(N/2*0.382)=1/2
C=a2.^((NT:-1:1)-1);
plot(tT,C,'c')
L1=NT*.382;L2=NT-L1;
S1=sum(C(1:L1));S2=sum(C(L1+1:end));
H1vsH2=S2/S1;
H2=1/(1+H1vsH2);
x2=x/2-H2;
plot(t,x2,'r');
y2=filter(1,[1,-a2],x2);%这实际上是在积分
y22=y2/((1-H2)/(1-a2));%通过令z=1，根据终值定理把y2的渐近线化为1

plot(t,y22,'m')