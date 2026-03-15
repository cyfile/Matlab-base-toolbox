% 3.7 状态空间表达式的能控标准型与能观标准型
%
% https://www.mathworks.com/help/control/ug/canonical-state-space-realizations.html
%   能控标准I型   =  Controllable Canonical Form  =  sys_ctr_I
%   能控标准II型  =  Controllable Companion Form  =  sys_obs_I
%   能观标准I型   =  Observable Companion Form    =  sys_obs_I.'
%   能观标准II型  =  Observable Canonical Form    =  sys_ctr_I.'
% 
%

clc,clear
%%  ====== 构建测试系统 ======
switch 2
    case 1
        beta = poly([1,3]);
        alpha = poly([2,4,6,8]);
        H = tf(beta,alpha);
        H = zpk([1,3],[2,4,6,8],1);
    case 2
        beta = [3,4,5];
        alpha = [1,2,3,4,5];
        H = tf(beta,alpha);
end
%% ====== 前提条件 ======
sys = ss(H);
[A,b,c,~] = ssdata(sys);
model_order = order(sys);
Co = ctrb(A,b);
Ob = obsv(sys);
% 只有能控(观)才能化为下面的标准型
check = [rank(Co), rank(Ob), model_order]
assert(rank(Co)==model_order,'系统不完全能控,不能化为能控标准型')
assert(rank(Ob)==model_order,'系统不完全能观,不能化为能观标准型')

size(sys)
disp('This example only covers SISO systems')
%% ====== Modal Form ======
%  doc modalreal  % for matlab R2023b or later
% [msys,blks] = modalreal(sys)

% csys = canon(csys_o,'modal',condt);
[msys,T] = canon(sys,'modal');
A_jordan = msys.A;

%% ====== 能控标准I型 ======
% Controllable Canonical Form
% 
T_cI = fliplr(Co)*tril(toeplitz(alpha(1:end-1)));
sys_ctrb_I = ss2ss(sys,inv(T_cI));
[A_ctrb_I,b_ctrb_I,c_ctrb_I,~] = ssdata(sys_ctrb_I);

% --- 来自知乎的另一种方法,另一种代码 ---
% https://zhuanlan.zhihu.com/p/129295463
s = inv(Co); 
n = model_order;
T_c2o=[s(n,:);s(n,:)*A;s(n,:)*A^2;s(n,:)*A^3];
%T_c2o=[s(2,:);s(2,:)*A;s(2,:)*A^2;s(2,:)*A^3];
[inv(T_cI),T_c2o]
% --- 希望日后能明白这种方法的由来 ---

A_ctrb_I_2 = diag(ones(1,model_order-1),1);
A_ctrb_I_2(end,:)=-fliplr(alpha(2:end));
c_ctrb_I_2 = [beta(end:-1:1), zeros(1, model_order - length(beta))];
b_ctrb_I_2 = [zeros(model_order-1,1);1];
disp('[A_ctrb_I b_ctrb_I; A_ctrb_I_2 b_ctrb_I_2] =')
disp([A_ctrb_I b_ctrb_I ; A_ctrb_I_2 b_ctrb_I_2])
disp('[c_ctrb_I ; c_ctrb_I_2] =')
disp([c_ctrb_I ; c_ctrb_I_2])

%% ====== 能控标准II型 ======
% Controllable Companion Form
% [osys,T] = compreal(sys,"o")  since R2023b
% 
[sys_ccom_II_0,T]= canon(sys,'companion');
[A_ccom_II_0,b_ccom_II_0,c_ccom_II_0] = ssdata(sys_ccom_II_0);
%
T_cII = Co;
[inv(T_cII),T]
sys_ccom_II = ss2ss(sys,inv(T_cII));
[A_ccom_II,b_ccom_II,c_ccom_II,~] = ssdata(sys_ccom_II);
A_ccom_II_2 = diag(ones(1,model_order-1),-1);
A_ccom_II_2(:,end)=-alpha(end:-1:2);
b_ccom_II_2 = [1;zeros(model_order-1,1)];
c_ccom_II_2 = c*Co;
disp("[A_ccom_II , A_ctrb_I'] =")
disp(round([A_ccom_II , A_ctrb_I'],5))
disp('[A_ccom_II b_ccom_II; A_ccom_II_2 b_ccom_II_2] =')
disp([A_ccom_II b_ccom_II ; A_ccom_II_2 b_ccom_II_2])
disp('[c_ccom_II ; c_ccom_II_2] =')
disp([c_ccom_II ; c_ccom_II_2])

%% ====== 能观标准I型 ======
% Observable Companion Form
% [osys,T] = compreal(sys,"o")  since R2023b
%
T_oI_inv = Ob;
sys_ocom_I = ss2ss(sys,T_oI_inv);
[A_ocom_I,b_ocom_I,c_ocom_I,~] = ssdata(sys_ocom_I);

disp("[A_ocom_I , A_ocom_II'] =")
disp(round([A_ocom_I , A_ccom_II'],5))
disp("[b_ocom_I ; c_ccom_II'] =")
disp([b_ocom_I , c_ccom_II'])
disp("[c_ocom_I ; b_ccom_II'] =")
disp([c_ocom_I ; b_ccom_II'])

%% ====== 能观标准II型 ======
% Observable Canonical Form
% 
T_oII_inv = triu(toeplitz(alpha(1:end-1)))*flipud(Ob);
sys_obsv_II = ss2ss(sys,T_oII_inv);
[A_obsv_II,b_obsv_II,c_obsv_II] = ssdata(sys_obsv_II);

sys_tf=zpk(sys);
[num,den] = tfdata(sys);
disp("[A_obsv_II(:,end)' ; den(2:end)] =")
disp([A_obsv_II(:,end)' ; den{1}(2:end)])
disp("[b_obsv_II ; num(2:end) =")
disp([b_obsv_II , num{1}(2:end)'])
disp("b_obsv_II ; A_ctrb_I =")
disp([[A_obsv_II;c_obsv_II]' ; [A_ctrb_I,b_ctrb_I]])

%% === montage ===
% 
temp={A_ctrb_I;A_ccom_II;A_ocom_I;A_obsv_II;...
    b_ctrb_I;b_ccom_II;b_ocom_I;b_obsv_II;...
    c_ctrb_I;c_ccom_II;c_ocom_I;c_obsv_II}';
color_N = 13;
color_map = colorcube(color_N);
color_map = hsv(8);
color_map = lines(color_N);

imagelist= cellfun(@(a) mod(round(a),color_N)+1, temp, ...
    'UniformOutput', false);

%%
tiledlayout(2, 2,  'TileSpacing', 'Compact', 'Padding', 'Compact');
nexttile
montage(imagelist(1:4:12),color_map) % BorderSize=[3,3]
title('Controllable I')
nexttile(3)
montage(imagelist(2:4:12),color_map) 
title('Controllable II')
nexttile(2)
montage(imagelist(3:4:12),color_map) 
title('Observable I')
nexttile(4)
montage(imagelist(4:4:12),color_map) 
title('Observable II')

% A 阵中的 对角线1   在主对角线上方 是 I 型
%                   在主对角线下方 是 II 型
%
% b 阵中 有唯一的一个1   是 能控 型
% c                     是 能观 型
%
% A和b阵中的1能连起来 是 canonical form
% A和c阵中的1能连起来 是 canonical form
%           连不起来 是 companion form

