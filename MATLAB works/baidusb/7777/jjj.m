% xxx
function xxx
arr=[0:1:5,6:-1:-5,-6:1:-1];
arr2=[0:2:5,6:-2:-5,-6:2:-1];
a=[kron(ones(1,10),arr),0];
a2=[kron(ones(1,20),arr2),0];
figure
subplot(311)
plot(a)
hold on
plot(a2,'r')

f=fft(a);
f2=fft(a2);
f3=pp3(a,'linear');
subplot(312)
plot(abs(f))
hold on
plot(abs(f2),'r')
plot(abs(f3),'g')

subplot(313)
plot(angle(f))
hold on
plot(angle(f2),'r')
plot(angle(f3),'g')

subplot(311)
% plot(ifft(f3))
plot(real(ifft(f3)),'g')

function f=pp3(a,method)
n=length(a);
fo=fft(a);

w=exp(1j*2*pi/n);
ind=w.^(0:n-1);
in=real(ind)>0;

nf=fo(in);

x=[1:2:n/2,fliplr(n:-2:n/2)-1];
f = interp1(x,nf,1:n,method,'extrap');

end
end