function ndata=mag2per(data)
y=data(1:end-1,:);
x=data(2:end,:);
ndata=(x-y)./y;