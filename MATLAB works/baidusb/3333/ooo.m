% complex eigenvalues and eigenvectors
x=pi/4;
a=sin(x);b=cos(x);
A=[b,-a;a,b];
[V,D]=eig(A)
eigshow(A)