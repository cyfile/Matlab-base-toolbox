function M=tree_FCN_hole(xx,yy,rin)
a=192;
col=round(xx/64);
row=-round(yy/64);
n = max(abs([col(:);row(:)]));
if n <= a
    b = 0;
    A = zeros(2*a+1);
    A(sub2ind(size(A),row+a+1,col+a+1))=1;
else
    b = n - a;
    A = zeros(2*n+1);
    A(sub2ind(size(A),row+n+1,col+n+1))=1;
end

%%
r0 = round(rin/64);
[x,y]=meshgrid( -r0:r0 );
r = abs(x+1i*y);
B=zeros(size(x));
B(r<=r0)=1;
%%
A=conv2(A,B,'same');
M = A(b+1:end-b,b+1:end-b);
