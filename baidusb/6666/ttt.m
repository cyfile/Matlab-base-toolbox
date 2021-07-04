% problem3.m
%%%%%%%%%%%%%%
%问题三模型
%%%%%%%%%%%%%%
redgrape=[3,2,1]*mapminmax(A',0,1)/6;
redgrape=[0,2,1]*mapminmax(A',0,1)/3;

redtarget=[mainredwinetarget, mainredwinefrag];

[r,p] = corrcoef([redgrape',mainredwinetarget]) ;
r(2:end,1)
% p(:,1)

[r,p] = corrcoef([redgrape',mainredwinefrag]) ;
r(2:end,1)
% p(:,1)
%-----------------------------------------------------------
whitegrape=[3,2,1]*mapminmax(B',0,1)/6;
whitegrape=[0,2,1]*mapminmax(B',0,1)/3;
whitetarget=[mainwhitewinetarget  ,mainwhitewinefrag];

[r,p] = corrcoef([whitegrape',mainwhitewinetarget]) ;
r(2:end,1)
% p(:,1)

[r,p] = corrcoef([whitegrape',mainwhitewinefrag]) ;
r(2:end,1)
% p(:,1)