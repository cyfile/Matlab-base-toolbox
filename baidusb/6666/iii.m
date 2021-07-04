% 算法系列（8篇）——第五篇 分治思想第六篇 回溯思想第二篇 递归思想(matlab)
单循环赛制 对阵表生成

有n位选手参加比赛，比赛要进行n-1天，每位选手都要与其他每一个选手比赛一场并且每位选手每天都要比赛一场，请根据比赛要求排出选手的比赛日程表.

如n=2，生成矩阵：
[1 2；
2 1]
如n=4，可以生成矩阵：
[1 2 3 4；
2 1 4 3；
3 4 1 2；
4 3 2 1]
如n=6，可以生成矩阵：
[1 2 3 4 5 6;
2 1 5 6 4 3;
3 4 1 5 6 2;
4 3 6 1 2 5;
5 6 2 3 1 4:
6 5 4 2 3 1]

 %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%

方法一：递归

function A=aaa

n=10;
% n=input('输入一个偶数:\n');
nk=nchoosek(1:n,2);
nk=nk';


A=zeros(n);
A(:,1)=1:n;
A(1:2:n,2)=2:2:n;
A(2:2:n,2)=1:2:n;

tp=cumsum([0,n-1:-1:2]')+1;
col2=tp(1:2:n);
al=nk;
al(:,col2)=[];
k=n/2;
for kk=3:n
    col=R(al,k);
    tmp=al(:,col);
    v=tmp([2,1],:);
    %     v=flipud(tmp);
    A(tmp(:),kk)=v(:);
    al(:,col)=[];
end

function col=R(al,k)

for t=find(al(1,:)==al(1))
   
    pal2=~any(al==al(1,t)|al==al(2,t));
   
    if sum(pal2)==0
        continue
    end
    if sum(pal2)==1
        if k==2
            col=pal2;
            col(t)=1;
            return
        else
            continue
        end
    end
   
    c=R(al(:,pal2),k-1);
   
    if isempty(c)
        continue
    else
        col=false(size(pal2));
        col(pal2)=c;
        col(t)=1;
        return
    end
   
end
col=[];

 

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%

方法二：逆时针轮转方法

clear
n=8;  
k=[2:2:n,3:2:n];  
m(k-1)=1:n-1;  
l=toeplitz([1,n-1:-1:2],1:n-1);  
p=k(l(m,:));  
p(logical(eye(n-1)))=1;        
A=[(1:n)',[2:n;p]]

方法三：

a=[1,2;2,1];  
n=8;  
for k=2.^(1:(log2(n)-1))  
    b=k+1:1:2*k;  
    c=b(a);  
    A=[a,c;c,a];  
    a=A;  
end  
A
 