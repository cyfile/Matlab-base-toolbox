%Pn=rand(5,4);
%%
[r,c]=size(Pn);
Pn_sort=sort(Pn,2);
%plot(Pn_sort')
%
col = ceil(c*0.2);
val =max(Pn_sort(:,col))/(c-col+1)*(c:-1:1);
[~,ind]=min(abs(Pn_sort - val),[],2);
% [~,b]=min(abs(temp - val),[],2,'linear'); matlab2021 Option

F=Pn_sort(ind*r-(r-1:-1:0)');
noise_r= min( F./Px  , 1 );
%%
A=quantile(Pn,0.5,2).*quantile(Pn,0.35,2).*quantile(Pn,0.65,2)./quantile(Pn,0.2,2)./quantile(Pn,0.8,2);
B=2*quantile(Pn,0.5,2);
C=mean(Pn,2);
D=median(Pn,2);
plot([A,B,C,D,F])
legend('Cx','2x','mean','median','linear')
