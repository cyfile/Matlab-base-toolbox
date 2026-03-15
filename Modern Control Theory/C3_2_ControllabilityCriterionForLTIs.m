% 3.2 线性定常系统的能控性判别
%
clc,clear
%%

%%
clc,clear
N = 5;
B = eye(N);
res = zeros(N,N,N);

for k=1:N
    b= B(:,k);
    for h=1:N
        A=rand(N);
        for g = N:-1:1
            A(g:end,1:h) = 0;
            rk = rank(ctrb(A,b));
            [A,nan(N,1);nan(1,N+1);b',rk]
            res(g,h,k) = rk;
        end
    end
end
res

%
h=3;g=2;
A=rand(5);
A(g:end,1:h)=0;
disp('------ caution! ------')
A,arrayfun(@(k) rank(ctrb(A,B(:,k))), 1:N)
shiftdim(res(g,h,:),1)
disp('似乎存在一个上限')
disp('------ amazing! ------')


