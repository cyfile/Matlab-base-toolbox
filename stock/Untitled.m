
odata = dlmread('sh999999.txt','\t',2,1);
len=length(odata);

% plotjdk(odata)

data=mag2per(odata);
data=[zeros(1,6);data];
 
[y,PS] = mapminmax(data');

my=mat2cell(y,6,ones(1,len));

%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%

ind=15:len-2;
% hold on
% plot(ind',2400*ones(size(ind))','*k')
P=my(ind);



Pi=my(1:14);
%%%%%%%%%%%%%%%
data=odata(:,1:4)';
simpledata=(2*data(1,:)+2*data(4,:)+...
     data(2,:)+data(3,:))/6;
meandata=filter(ones(1,3),1,simpledata)/3; 

md=meandata(14+3:end);%(15+2=17):length(meandata)
sd=simpledata(14:end-3);

nn=nan(1,13);
% hold on 
% plot([nn md]','r');plot([nn sd]','g')
t=md-sd;

% figure
% plot(t)
lv1= mean(t)-.5*std(t);
lv2= mean(t)+.5*std(t);
% hold on
% plot(size(t),[lv1 lv1],'y')
% plot(size(t),[lv2 lv2],'m')
Tt=t;
Tt(t<lv1)=1; %die
Tt((lv1<t)&(t<lv2))=2;
Tt(t>lv2)=3;  %zhang
% plot(10*Tt,'*')

T=ind2vec(Tt);
T = mat2cell(T,3,ones(1,len-14-2));

ftdnn_net = timedelaynet([1:14],16);
ftdnn_net = configure(ftdnn_net,P,T);
net = train(ftdnn_net,P,T,Pi);
% view(net)
% [Xs,Xi,Ai,Ts] = preparets(ftdnn_net,P,T);
%%%%%%%%%%%%%%%%%%%%%%%%%
%foresee
%%%%%%%%%%%%%%%%%%%%%%%%

Xi=my(end-13:end);
foresee = net({zeros(6,1)},Xi);

% x=my(end-15:end);
% Xi=x(1:14);
% Xs=x(15:end);
% foresee1 = net(Xs,Xi);
% s=foresee1{2};
% foresee2= net({zeros(6,1)},my(end-14:end-1));
% s2=foresee2{1};

%%%%%%%%%%%%%%%%%
plot(cell2mat(X));
n=feedforwardnet(20);
view(n)
view(net2)
