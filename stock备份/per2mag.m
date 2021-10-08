function ndata=per2mag(data,k)
if nargin ==1
    k=ones(1,size(data,2));
end

d=[k;data+1];
ndata=cumprod(d);