%  生成劳斯表
%
clc,clear
choice = randi(5);
choice = 5;
switch choice
    case 0
        p = [1,100*rand(1,randi([6,9]))];
    case 1
        p = poly([-1])
    case 2
        % 卢姥爷 例2
        p = [1,5,7,2,10];
    case 3
        % 卢姥爷 例3 无穷小
        p = [1,0,-3,2];
    case 4
        % 卢姥爷 例4 全零行
        % 由于数值计算的误差,这个结果是对的
        % 不知道是否存在必然性
        p = [1,3,12,20,35,25];
    case 5
        % 卢姥爷 例5 全零行
        p = [1,2,0,0,-1,-2,0];
        p = [1,2,0,0,-1,-2];

    otherwise
        disp('other value')
end

N = length(p)-1;
even_flag = mod(length(p),2)==0;
P = reshape([p,0:-even_flag],2,[]);
routh_mat = routh_cal(P,N);

routh_table = [P;routh_mat];
for k = 1:N+1
    pow = N-k+1;
    fprintf(' S^%d ', pow)
    fprintf('%12.4g', routh_table(k,:));
    if true && pow > 0
        temp = routh_table([k,k+1],:);
        fprintf('%5s/' ,'');
        try
            fprintf('%12.4g', real(roots(temp(1:pow+1)) ))
            %         catch e
        end
    end
    fprintf('\n')
end




%% =====================
function routh_matrix = routh_cal(coffs,n)

    m1= ceil(n/2);
    m2 = floor(n/2);

    routh_line = zeros(1,m1);
    for k=1:m2
        routh_ele = - det(coffs(:,[1,k+1]))/coffs(2);
        if isnan(routh_ele)
            % only coffs(2)==inf considered, 
            % more code may be needed 
            % for other case to ensure correctness.
            routh_ele = coffs(1,k+1);
            %  coffs(:,[1,k+1]) % for debug
        end
        routh_line(k) = routh_ele;
    end
    % disp(routh_line) % for debug
    if all(routh_line == 0)
        warning('all 0 row !! (power = %d)', n)
    
        % abandoned code
        %         poly_temp = polyder( kron(coffs(2,:),[1,0]) )
        %         routh_line = [poly_temp(1:2:end)];
    
        routh_line = coffs(2,1:m1).*(n-1:-2:0);
    end
    %     disp(routh_line) % for debug    
    if n > 2
        table_sub = routh_cal([coffs(2,1:m1);routh_line],n-1);
        routh_matrix = [[routh_line;table_sub],zeros(n-1,m1==m2)];
    else
        routh_matrix = [routh_line,0];
    end
end
