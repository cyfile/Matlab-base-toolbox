% 最长公共子序列LCS(matlab)
程序一，递归

function lcstr=lcs(A,B)
%
if nargin==0
    a='ACGTAACCT';b='GGACTAGG';
end
%%%%%%%%%%%%%%%%%
% if length(a)>length(b)
%     tem=a;
%     a=b;
%     b=tem;
% end
lcstr=R(a,b);
%%%%%%%%%%%%%%%%%
function st=R(sa,sb)
[s, ai] = unique(sa, 'first');
leng=-1;
st=[];
for k=1:length(s)
    bi=find(sb==s(k),1);
   
    if isempty(bi)
        continue
       
    elseif ai(k)==length(sa) || bi==length(sb)
       
        if leng==-1
            st=s(k);
            leng=0;
        end
       
    else
        st2=R( sa((ai(k)+1):end), sb(bi+1:end) );
        if length(st2)>leng
            st=[s(k),st2];
            leng=length(st2);
         end
    end
end

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

程序二，

function [str con]=lcs(a,b)
if nargin==0
    a='ACGTAACCT';b='GGACTAGG';
end

r=length(a);
c=length(b);
M=zeros(r,c);
for k=union(a, b)
    for x=find(a==k)
        for y=find(b==k)
            M(x,y)=x+y;
        end
    end
end

res=zeros(1,r);
con=0;

while r>0 && c>0
    m=M(1:r,1:c);
    [val,ind]=max(m(:));
    if val <1
        break
    end
    [r c]=ind2sub([r,c],ind);
   
    con=con+1;
    res(con)=r;
   
    r=r-1;
    c=c-1;
end
str=a(res(con:-1:1));