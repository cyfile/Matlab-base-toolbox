% 解数独(一,利用规划函数intlinprog)
% doc('Solve Sudoku Puzzles Via Integer Programming')
A=dlmread('shuju.txt');
tic
A= [0,2,0,0,3,0,0,4,0
    6,0,0,0,0,0,0,0,3
    0,0,4,0,0,0,5,0,0
    0,0,0,8,0,6,0,0,0
    8,0,0,0,1,0,0,0,6
    0,0,0,7,0,5,0,0,0
    0,0,7,0,0,0,6,0,0
    4,0,0,0,0,0,0,0,8
    0,3,0,0,4,0,0,2,0];

f = (1:9*9*9)';
intcon = 1:9*9*9;

aeq=kron(eye(81),ones(9,1));
aeq=reshape(aeq,3,3,3,3,3,3,81);
Aeq = cat(7,...
    aeq,...
    permute(aeq,[3,4,1,2,5,6,7]),...
    permute(aeq,[5,6,3,4,1,2,7]),...
    permute(aeq,[1,3,2,4,5,6,7]));
Aeq=reshape(Aeq,9*9*9,[])';
beq=ones(4*9*9,1);
%spy(Aeq)

ub=ones(9,9,9);
lb=zeros(9,9,9);
for k=1:9
    lb(:,:,k)=A==k;
end
%all(Aeq*logical(lb(:))<=1) 检测A是否合理
[x,~,eflag] = intlinprog(f,intcon,[],[],Aeq,beq,lb,ub);

ind=find(x);
[I,V] = ind2sub([81,9],ind);

R=zeros(9);
R(I)=V;
toc
drawSudoku(R,A)