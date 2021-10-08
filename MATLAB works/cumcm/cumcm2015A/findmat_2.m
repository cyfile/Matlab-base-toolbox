function [fval,Tmat,L,theta,vec]=findmat_2(XY,xy)

tform = fitgeotrans([0,0;XY],[0,0;xy],'NonreflectiveSimilarity');
new=[0,0,1;XY,ones(21,1)]*tform.T;
dif=[new(:,1:2)]-[0,0;xy];
fval=sum(sum(dif.*dif,2));
fval=log(fval);

Tmat = tform.T(1:2,1:2);
L=hypot(Tmat(1),Tmat(2));
theta=acos(Tmat(1)/L);
vec=tform.T(3,1:2);

end