x= [10.0100 11.2600  9.0000  9.0900  9.4400  9.0900  8.7300  8.6800  9.0400 ...
    9.0450 10.0500 7.3300  6.1900  5.6800  5.8600  5.6300  5.5600  5.6400  5.7000  6.3600];
y=x;
x= [y' 2*y'];

[L,N]=size(x);
a = lpc(x,3);
est_x = zeros(L+1,2);
%%
for k=1:N
    est_x(:,k) = filter([0 -a(k,2:end)],1,[x(:,k);rand]);
end
est_x(end)
plot(x)
hold on
plot(est_x)
plot(L+1,est_x(end,:),'*g')
%%%%%
est_x2 = filter([-a(1,2:end)],1,x(:,1));
isequal(est_x2(end),est_x(end,1))