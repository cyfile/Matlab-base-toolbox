% linkaxes and linkprop
n=20;
theta=linspace(0,2*pi,n);
k=exp(1j*theta);
m=zeros(1,n);

a1=subplot(221);
plot(m,imag(k),'linewidth',3)
a2=subplot(222);
plot(real(k),imag(k),'linewidth',3)
a4=subplot(224);
plot(real(k),m,'linewidth',3)

% linkaxes([a1,a2],'y')
% linkaxes([a4,a2],'x')
lky=linkprop([a1,a2],'ylim');
lkx=linkprop([a4,a2],'xlim');