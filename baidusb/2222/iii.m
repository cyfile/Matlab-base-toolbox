% Lissajous curve
sigma=2^(1/12);
t=0:.1:100;
a=5/4;
b=sigma^4;

x=sin(t);
y=sin(a*t);
z=sin(b*t);

subplot(121)
plot(x,y)
subplot(122)
plot(x,z)