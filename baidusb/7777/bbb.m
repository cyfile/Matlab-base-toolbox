% DistributionFitting
x=normrnd(2,4,1,100);

[muhat,sigmahat,muci,sigmaci]=normfit(x)



mu=mean(x)

sigma=sqrt(var(x))



p=sigma*tinv(0.025,99)/sqrt(100);

mci=[mu+p,mu-p]



p2=sqrt(var(x,1))*tinv(0.025,99)/sqrt(100);%%好像这个是对的

mci2=[mu+p,mu-p]



p3=4*norminv(0.05/2,0,1)/sqrt(100);

mci3=[mu+p,mu-p]