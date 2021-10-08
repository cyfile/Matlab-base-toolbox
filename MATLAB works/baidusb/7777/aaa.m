% covandcorrcoef
a=rand(4);
m1=corrcoef(a)
b=cov(a);
m2=b./sqrt(diag(b)*diag(b)')%m1==m2
%%R = V./(SD*SD'), where SD = sqrt(diag(V))
doc pcacov