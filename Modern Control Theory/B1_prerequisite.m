% prior knowledge
% background knowledge

%% ====== Pole <-> Polynomial <-> Matrix <-> sys ======

% ---------------------------
% Pole <-> Polynomial
lambda_root = -rand(4,1);
p = poly(lambda_root);
r = roots(p);
disp([lambda_root,r])

% ---------------------------
% Polynomial <-> Matrix
A = compan(p);
A2 = rot90(compan(p), 2); % 可控I型
p2 = poly(A2);
disp([p;p2])

% ---------------------------
% Pole <-> Matrix
e = eig(A);
disp([lambda_root,e])

% ---------------------------
% Matrix <-> sys
sys = ss(A,[],[],[]);
temp=get(sys,"A");
A2 = temp{1};
[A3,~] = ssdata(sys);
A4 = sys.A;
disp([A,A4])

% ---------------------------
% Pole <-> sys
sys_zpk = zpk([],lambda_root,1);
e2 = pole(sys);
e3 = pole(sys_zpk);
disp([lambda_root,e2])

% ---------------------------
% Polynomial <-> sys
sys_tf = tf(1,p,1);
p3 = tf(sys_tf).den{1};
disp([p;p3])




%% ====== sys cell set ======

H ={
    zpk([],[1,1,2],1),...
    zpk([],[1,2,3,4],1),...
    zpk([],[-2+1i,-2-1i],1),...
    zpk([],[-2+1i,-2-1i,-2+1i,-2-1i],1),...
    zpk([],[1,1,2,2,2,3,4],1),...
    zpk([],[1,1,2,2,2,-3+4i,-3-4j,5,6],1),...
    };
N= length(H);
sys =  H{randi(N)}


%% ====== 判断矩阵相等 ======
A = rand(4);
B = A + eps*rand(4);
y = A-B;
[A,B]
[norm(A-B),max(svd(A-B))]
[norm(A-B,1),max(sum(abs(A-B)))]
[sum(sum(abs(A-B))) sum(abs(y(:))) sum(abs(A-B),"all")]
[max(max(abs(A-B))) max(abs(y(:))) max(abs(A-B),[],"all")]


%%

% ---------------------------


