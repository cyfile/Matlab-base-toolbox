

return

%%
sys_co =rss(3,2,0)
sys_cx =rss(3,2,0)
sys_xo =rss(3,2,0)
sys_xx = rss(1,0,0)


%%
% 通过相似变换分解系统


    [A_bar, B_bar, C_bar, T] = obsvf(P.A, P.B, P.C);
    A_unobs = A_bar(rank_O+1:end, rank_O+1:end);
    C_unobs = C_bar(:, rank_O+1:end);
    sys_unobs = ss(A_unobs, zeros(size(A_unobs,1),1), C_unobs, 0);

%%
% sys = rss(3,1,1);
A = sys.A;
B = sys.B;

sys_tf = zpk(sys);
celldisp(sys_tf.p)
%%

% for 李雅普诺夫第二法(直接法)
doc quiver contour(X,Y,Z)