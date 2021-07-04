% logistic2

clear
%%%%%%%%%%%
n=.3; %x0
m=3; %lamda
%%%%%%%%%%%
x0=.1:.1:.9;
lamda=0:.1:4;
xn=1:140;

x0_n=find(single(x0)==single(n));
lamda_m=find(single(lamda)==single(m));
%%%%%%%%%%%%%%%
%%%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%%%
% % lamda(1,1,:)=lamda;
% % zd=length(lamda);
% %
% % x0(1,:,1)=x0;
% % yd=length(x0);
% %
% % lam=repmat(lamda,[1,yd,1]);
% % x=repmat(x0,[1,1,zd]);
% % %%%%%%%%%%%%%%
% % x=meshgrid(x0,lamda);
% % x=permute(x,[3,2,1]);  %%%x= shiftdim(x,-1);
% % %%%%%%%%%%%%%%
[null1,x,lam]=ndgrid(1,x0,lamda);
%%%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%%%%%%%%%%%%
%%%%%%%%%%%%%%%


for i=xn
    x(i+1,:,:)=lam.*x(i,:,:).*(1-x(i,:,:));
end

xaxis=kron(ones(1,length(x0)),[0,xn]');
yaxis=repmat(x0,size(x,1),1);

figure(1)
set(gcf,'DefaultAxesColorOrder',winter(9));
h1=plot3(xaxis,yaxis,x(:,:,1),'zDataSource','newx');
%axis
xlabel('n')
ylabel('x0')
zlabel('xn')
% set(gca,'colororder',winter(9))
% hold on

for i=2:size(x,3)
    newx=x(:,:,i);
    refreshdata(h1,'caller')
    drawnow;
    pause(.2)
end
pause(1)
view(0,83)

%^_^    ^_^    ^_^    ^_^    ^_^    ^_^    %
%^_^    ^_^    ^_^    ^_^    ^_^    ^_^    %

figure(2)
axis;
set(gca,'colororder',winter(9))
hold on

xx=0:.05:1;
yy=lamda(lamda_m)*xx.*(1-xx);
plot(xx,[yy;xx],'r')


xlabel('xn')
ylabel('x(n+1)')
str(1) = {['\lambda=',num2str(m)]};
str(2) = {['X_0=',num2str(n)]};
text(.1,.85,str);
%xx=x(:,1);
xf2=kron(x(:,x0_n,lamda_m),[1;1]);
yf2=xf2(2:end,:);

yf2(1,:)=0;
xf2(end,:)=[];

h2=plot(xf2,yf2,'xDataSource','xf2','yDataSource','yf2');