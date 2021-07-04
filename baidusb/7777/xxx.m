% recursion
function A=recursionfuc(a)
%iterate iteration
%recur recursion

if a==2
    B=1;
else
    B=recursionfuc(a-1)
end
A=a*B;