% ´íÎ»Ë÷ÒýºÍfunm
x = 1:5; y = (1:10)';

% Replace this code
repmat(x,10,1) + repmat(y,1,5)
% with the following:
bsxfun(@plus, x, y)

toeplitz([1,4:-1:2],1:4)
hankel(1:4,[4:7])

funm(ones(2), @exp)
exp(ones2)