function [fval,Tmat,L,theta,vec]=findmat(XY,xy)

[x,fval,exitflag,output]=fminsearch(@(x) f(x(1),x(2)),[1,0]);
%fval=log(fval);
Tmat=x(1)*[cos(x(2)) sin(x(2));-sin(x(2)) cos(x(2))];
L=x(1);
theta=x(2);
vec=[0,0];

    function val=f(a,b)
        err=a*XY*[cos(b) sin(b);-sin(b) cos(b)]-xy;
        val=sum(sum(err.*err));
        %val=log(val);
    end
end