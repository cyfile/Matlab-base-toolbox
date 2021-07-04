% Fibonacci SequenceÑî»ÔÈý½Ç
phi=@(n)(n+sqrt(4+n.^2))/2;
stem(phi(0:10))

 

a=[zeros(1,10),1,zeros(1,10)];
for k=1:10
a=diff(a)
% plot(a)
% pause(.1)
end

 

 

k=impz(1,[1,-1,-1],10)
filter(1,[1,-1,-1],zeros(1,10),[1 0])
filter(0,[1,-1,-1],zeros(1,10),[1 0])
k=stepz([1,-1],[1,-1,-1],10)

 

a=[0,1,1;1,0,0;0,1,1];
sys = ss(a,[],ones(1,3),[],-1); 
y=initial(sys,[1,0,0]',0:9) 

 

 

[b,a] = eqtflength(1,[1,-1,-1]);
%[b,a] = eqtflength([1,-1],[1,-1,-1]);
[A,B,C,D]=tf2ss(b,a);
%[A,B,C,D]=tf2ss(1,[1,-1,-1]);
sys = ss(A,B,C,D,-1); 
y=initial(sys,[0,1]',0:9)