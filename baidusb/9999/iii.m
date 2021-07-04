% logistic4


clear
mylogistic=@(n,lambda)lambda*n.*(1-n);

x0=0.1:0.005:0.4;
lambda=3.4:0.001:3.9;
for lam=1:length(lambda)
xn=x0';  
for k=2:1200
% xn(:,k)=feval(mylogistic,xn(:,k-1);
xn=feval(mylogistic,xn,lambda(lam));
end
rn(lam,:)=xn;
end

plot(rn,'k.')

% % n=10
% % while n=n-1
% %     n
% % end
% %
% % am=2;
% % an=4;
% % ak=.01;
% % m=1200;
% % x=0:.01:1;
% % n=fix((an-am)/ak);
% % for k=1:n
% %     a=k*ak+am;
% %     y=x;
% %     for j=1:m
% %         z=a*y.*(1-y);
% %         y=z;
% %     end
% %     u(k,:)=z;
% % end
% % plot(u,'.k')