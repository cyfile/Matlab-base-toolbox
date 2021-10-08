% scissors

% % a=3*rand(1,10000);
% % A=floor(a);
% % %%%%%%%%
% % b=3*rand(1,10000);
% % B=floor(b);
% % %%%%%%%%%%
% % c=mod(A-1,3);
% % C=[randi(3)-1,c(1:end-1)];
% % %%%%%%%%
% % n=hist(A-C,[-2,-1,0,1,2]);
% % [n(1)+n(4),n(3),n(2)+n(5)]
% % %rel./sum(rel)
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
% % rel=zeros(1,3);
% % Ba=randi(3)-1;
% % for k=1:10000
% %     A=randi(3)-1;
% %     B=mod(Ba-floor(2*rand+0.2),3);%%mod(Ba-1,3);
% %     n=hist(A-B,[-2,-1,0,1,2]);
% %     rel=rel+[n(1)+n(4),n(3),n(2)+n(5)];
% %     Ba=A;
% % end
% % rel
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

rel=zeros(1,3);
Ba=1;
Ab=0;

for k=1:10000
    A=mod(Ab-1,3);
    B=mod(Ba-floor(2*rand+0.2),3);%%mod(Ba-1,3);
    n=hist(A-B,[-2,-1,0,1,2]);
    rel=rel+[n(1)+n(4),n(3),n(2)+n(5)];
    Ba=A;
    Ab=B;
end
rel(1)-rel(3)
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$