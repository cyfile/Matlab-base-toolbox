% 指派问题 二分图最大匹配 TSP 最小生成树
n=5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=randi([1,9],n);
a=A(:);
eq1=kron(eye(n),ones(1,n));
eq2=kron(ones(1,n),eye(n));
X=bintprog(a,[],[],[eq1;eq2],ones(2*n,1));%过时的函数
x=reshape(X,n,n)
sum(A(x==1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% assignDetectionsToTracks
% 检测点和标记点的匹配
[assignment, unassignedTracks, unassignedDetections] = assignDetectionsToTracks(A, 100);
x2=zeros(n);
x2(double(assignment)*[1;n]-n)=1

%%%%%%%%%%%%%%%%%%%%%%%%%%%

匈牙利算法 Hungarian algorithm

http://csclab.murraystate.edu/bob.pilgrim/445/munkres.html

http://www.docin.com/p-471669250.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%

遍历所有边，欧拉回路

遍历所有顶点，哈密顿圈

TSP

open travel