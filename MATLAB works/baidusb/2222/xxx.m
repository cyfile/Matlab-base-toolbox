% the relationship between dct and dft

N=randi(8);
%% dft
Wf=dftmtx(N*2);
Wf*Wf'
all(all(abs(Wf*Wf'-2*N*eye(2*N))<eps(N)))
wfo=Wf/sqrt(2*N);
all(all(abs(wfo*wfo'-eye(2*N))<eps(N)))
%% dct
Wc=dctmtx(N);
Wc*Wc'
all(all(abs(Wc*Wc'-eye(N))<eps(N*2)))
%% dct 和 dft 的关系
%dct和dft在频域的频率范围是一样的，但dct的频率间隔是dft间隔的1/2，
%也即，dct在频域的分辨率是dft的2倍
%因此N点的dft包含的频率成分，要用2N个点的fft才能涵盖
tmpW=Wf(1:N,1:N);%前一个1:N表示dct没有负频率，
%后一个1:N表示n个样点的dct可以从后面补了n个零的新的2n个样点的序列的fft中得到
%%
%初相调整
%dct的各个频率成分具有线性的初相，而不像dft中所有频率成分的初相都为零
%dct的初相平均分布在[0,pi)之间，这样做是为了使初相尽量分散，
%尽可能避免出现的对dct变换的各个频率都有较大影响的点， 以降低这样的点出现的概率
phc=exp(1i*(0:N-1)*pi/(2*N));
%每个频率的成分有正余弦两个函数的线性组合表示，在频率表现为一个复数。
%fft有实部和虚部，可以完整的表示某个频率成分，dct只有一个数，只能舍弃一些该频率的成分
%这在时域表现在正余弦对于存在初相的余弦成分都有贡献，
%在频域表现在只取 原表示初相的复数 在 新的表示指定初相的频率复数方向上 的投影
tmpW2=real(bsxfun(@times,phc',tmpW));%乘以phc是将原初相和新初相都进行旋转，
%新初相会被旋转到实轴，接下来取实数就可以得到投影了
%%
%为了得到正交阵Wc，需要对幅值进行调整
%Wc的每一行是一个余弦函数，要保证自己对自己的内积为1，既保证自己的能量为1。
%由于是单位的正弦，其功率为1/2,直流幅值等效为sqrt(2)/2,为使功率归一化，幅值乘以sqrt(2)
%因为是离散的,要使平方和为1，每一项还要除以sqrt(N)
Wf2Wc=bsxfun(@times,[1,sqrt(2)*ones(1,N-1)]',tmpW2/sqrt(N));
%%%%%%%%%%%%%%%%%5
all(all(abs(Wc-Wf2Wc)<eps(N*2)))
%real(diag(相位向量)×diag(系数向量)×dftmtx(1:n/2,1:n/2))=dctmtx(n);
%因为有一个real的运算，
%所以下面的实例2，没能得到正确的结果
%%%%%%%%%%%%%%%
%% open dct
%open dct
%里面有一个当n是偶数时利用fft算dct的快速算法
%那里实际上是对序列的偶数位和奇数位分别求
%相对于定义中的初始相位共轭的两个相位方向上的投影。
%由于两部分的投影共轭，最终用real求实部，%
%便把两个余弦成分对于初始相位的余弦的贡献加了起来，
%得到了整个序列的dct
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 实例 1
n=5;
a=rand(1,n);
b=[a,zeros(size(a))];
a_c=dct(a);
b_f=fft(b);
b_c=[1,sqrt(2)*ones(1,n-1)]/sqrt(n).*...
    real(b_f(1:n).*exp(-1i*(0:n-1)*pi/(2*n)));
subplot(211)
plot(a_c,'o'),hold on
plot(b_c,'r')
%%%%%%%%%%%%%%%%%%%%%%%%%55
%% 实例 2
m=5;n=4;
a=rand(m,n);
b=zeros(m*2,n*2);
b(1:m,1:n)=a;
a_c=dct2(a);
b_f=fft2(b);
bc_c=(exp(-1i*(0:m-1)*pi/(2*m)).'*exp(-1i*(0:n-1)*pi/(2*n))).*b_f(1:m,1:n);
b_c=([1,sqrt(2)*ones(1,m-1)].'/sqrt(m)*[1,sqrt(2)*ones(1,n-1)]/sqrt(n)).*real(bc_c);
subplot(223)
imshow(a_c,[])
subplot(224)
imshow(b_c,[])
%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 实例 2 之所以错的说明,示意，非程序
% size(A)=m*n;
% dctmtx=real(V*dftmtx);
% fft2(A)_mn=dftmtx(2*m)_m*A*dftmtx(2*n)_n;
% dct2(A)=dctmtx(m)*A*dctmtx(n)'
%        =real(V(m)*dftmtx(2*m)_m)*A*real(V(n)*dftmtx(2*n)_n)'
%        =real(V(m)*dftmtx(2*m)_m)*A*real(dftmtx(2*n)_n*V(n))
%        =real(V(m)*dftmtx(2*m)_m*A*dftmtx(2*n)_n_mn*V(n))
%       ~=real(V(m)*fft2(A)_mn*V(n))