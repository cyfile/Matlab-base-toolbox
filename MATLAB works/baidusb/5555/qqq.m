% 判断线段是否和多边形区域有交点2
function isx=isx(plotflag)

l=rand(2);%直线上的两点
s=rand(4,2);%多边形顶点

TRI = delaunay(s);
s1=s(TRI(1,:),:);
s2=s(TRI(2,:),:);
%%
%%%%%%%%%%
Aeq=[1,-1]*l*[0,-1;1,0];
beq=Aeq*l(1,:)';
%(10*rand*[1,-1]*l+l(1,:))*Aeq'==beq
%%%%%%%%%%%
lb=min(l)';
ub=max(l)';
%%%%%%%%%
options = optimoptions('linprog','Display','off');
if isintersect(s1)==1
    isx=1;
elseif isintersect(s2)==1
    isx=1;
else
    isx=0;
end
%%%%%%%%%%%%%%%%%%%
%%%----------plot-------%%%%%%
if exist('plotflag','var')
    close all
    hold on
    plot(l(:,1),l(:,2),'-*r')
    plot(s1(:,1),s1(:,2),'^')
    plot(s2(:,1),s2(:,2),'v')
    % K = convhull(s);
    % if length(K)>4
    %     s=s(K(1:end-1),:);
    % end
    tmp=[intersect(TRI(1,:),TRI(2,:));setxor(TRI(1,:),TRI(2,:))];
    s=s(tmp(:),:);  %多边形顶点
    plot(s([1:end,1],1),s([1:end,1],2))
    axis equal
end
%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
    function exitflag=isintersect(s0)
       
        v=s0([2:end,1],:)-s0;
        r=s0([end,1:end-1],:);%cankaodian
       
        nv=v*[0,1;-1,0];%faxiangliang
        ax=sum(nv.*r,2);%diandaozhixiandeweiyi
        b=sum(nv.*s0,2);%diandaozhixiandeweiyi
       
        mask=ones(3,1);
        mask((ax>b))=-1;
       
        b=mask.*b;
        A=mask*[1,1].*nv;
        % for k=1:4 ;a=ginput(1), A*a'<b
        % end
        [~,~,exitflag]= linprog([],A,b,Aeq,beq,lb,ub,[],options);
    end
end