% cloth.m

clear
con=zeros(3,3,3,3);
% sci=0;
% ham=0;
% clo=0;
fra=randi(3,4,1);
rdn=randi(3,4,1);
a=rdn;
for w=4:1000

% newt=randi(3);
newt=randsrc(1,1,[setxor(a(end-1),[1,2,3]);.5 .5]);

rdn(w)=newt;
a(end)=newt;

 

con(a(1),a(2),a(3),a(4))= con(a(1),a(2),a(3),a(4))+1;

a=circshift(a,-1);


b=a(1:3);
for v=1:3
    c=[b;v];
    foc(v)=con(c(1),c(2),c(3),a(4));
    c=mod(c-2,3)+1;
    foc(v)=foc(v)+1*con(c(1),c(2),c(3),a(4));
    c=mod(c-2,3)+1;
    foc(v)=foc(v)+1*con(c(1),c(2),c(3),a(4));
end
tot=sum(foc);
if tot
    fra(w+1)=randsrc(1,1,[1,2,3;foc(1)/tot,foc(2)/tot,foc(3)/tot]);
else
    fra(w+1)=randi(3);
end
end
fra(1)=fra(end);
fra(end)=[];

n=hist(fra-rdn,[-2,-1,0,1,2]);

bar([-1,0,1],[n(2),n(3),n(4);n(1),0,n(5)]','stack')