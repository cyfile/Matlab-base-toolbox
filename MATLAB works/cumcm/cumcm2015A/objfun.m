function objval=objfun(n,e,N_datenum,Et_absolute,xy,time)
%
global calobjval calcoord

switch calcoord
    case 1 
        shadow_vec=polesun2shadow(n,e,N_datenum,Et_absolute);
    case 2 %考虑地球半径和地日距离
        shadow_vec=polesun2shadow_2(n,e,N_datenum,Et_absolute);
    case 4 %考虑地球半径和地日距离 并认为一天之中太阳直射的纬度会发生变化
        shadow_vec=polesun2shadow_4(n,e,N_datenum,Et_absolute,time);
end
%
%% 大气折射的简单模型 k为折射率
% leng=sqrt(sum(shadow_vec.*shadow_vec,2));
% sinalpha=k*leng./sqrt(leng.^2+1);
% shadow_vec=sinalpha./sqrt(1-sinalpha.^2);

switch calobjval
    case 1
        %% 缩放 旋转 不平移
        objval=findmat(shadow_vec,xy);
        
    case 2
        %% 缩放 旋转 平移
        objval=findmat_2(shadow_vec,xy);
        
    case 3
        %% 这种方法减少了很多匹配信息，虽然简单但是误差很大
        obj_vec=sum(xy.*xy,2);
        match_vec=sum(shadow_vec.*shadow_vec,2);
        objval=subspace(obj_vec,match_vec);
        %objval=log(subspace(obj_vec,match_vec));
end
