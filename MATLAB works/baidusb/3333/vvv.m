% Parseval's theorem in DFT
% 差个常数根号n不是正交阵，matlab有个命令dftmxt，怪不得怕晒娃儿要除个n



N=randi(8)
W=dftmtx(N);
%isequal(abs(W*W'),N*eye(N))
%复数矩阵转置时复数元素要取共轭
all(all(abs(W*W'-N*eye(N))<eps(N)))

%以下四行从W的生成角度，解释了为什么W×W‘的对角阵元素是个实数N

%W*W'中的每一个元素是原矩阵W的一行（列）向量与自己共轭向量的内积（相关）

%由于该行向量实部来自于余弦函数，虚部来自于负的正弦函数级V=cos(x)-i*sin(x),（x是个向量），

%而正弦和余弦正交，所以上述内积的虚数部分为0。

%而实数部分为正弦和余弦的平方和，即1，有N个元素，再乘以N。

 

%进而推出：
%W除以常数sqrt(N)变成正交阵
%这就是为什么离散信号的帕塞瓦尔定理要除N
WO=W/sqrt(N);
abs(sum(WO*WO'))

[V,~]=eig(W);
plot(abs(V));



 

aa=rand(128,1);
subplot(221)
plot(aa)
subplot(222)
plot(ifft(fft(aa)))
subplot(223)
plot(flipud(real(fft(fft(aa)))))
%傅立叶变换对称性的表现，但第一个点跑到了最后。
subplot(224)
mtx=dftmtx(128);
imtx=mtx';
plot(real(imtx*fft(aa)))
%%%%%%%%
mt=circshift(flipud(mtx),1);
isequal(mt,imtx)
all(all(abs(mt-imtx)<0.001))
all(all(abs(real(mt-imtx))<0.001))
all(all(abs(imag(mt-imtx))<0.001))