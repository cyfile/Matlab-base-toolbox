% draft
clc
clear
A=[8,0,0,0,0,0,0,0,0;
    0,0,3,6,0,0,0,0,0;
    0,7,0,0,9,0,2,0,0;
    0,5,0,0,0,7,0,0,0;
    0,0,0,0,4,5,7,0,0;
    0,0,0,1,0,0,0,3,0;
    0,0,1,0,0,0,0,6,8;
    0,0,8,5,0,0,0,1,0;
    0,9,0,0,0,0,4,0,0];
ind1=find(A);
ind2=A(ind1);
n=length(ind1);
B3=sparse(1:n,ind1,ones(1,n),n,81);
C3=sparse(1:n,ind2,ones(1,n),n,9);

b1=kron(eye(9),ones(1,9));
b2=kron(ones(1,9),eye(9));
a=kron(eye(3),ones(1,3));
b=kron(ones(1,3),a);
b3=kron(eye(3),b);

nB1=[b1;b2;b3];
[r,jb]=rref(nB1');

B1=nB1(jb,:);

C1=ones(21,9);

B=[B1;B3];
C=[C1;C3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M=null(B,'r');
N=B\C;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
[D,ind]=rref([B,C]);

k=81;
% % % % a1=rank(D);%%a=3*9-6+21;
% % % % a2=k-a1;
% % % % 
% % % % % Q=arrayfun(@(a) find(D(:,a)~=0,1,'last'),1:81);
% % % % % [b, m, n] = unique(Q, 'first');
% % % % 
loi=true(1,k);
loi(ind)=false;

% M1=D(1:a1,loi);
% M=zeros(k,a2);
% M(~loi,:)=-M1;
% M(loi,:)=eye(a2);


N1=D(:,k+1:end);
N=zeros(k,9);
N(~loi,:)=N1; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tm=-M*randi(5,39,9)+N;
tm2=B*tm-C;