% Hamiltonian

clear
[X,Y]=meshgrid(-2:.1:2);
Z=Y.*Y/2-X.*X/2+X.^4/4;
figure
mesh(X,Y,Z)
hold on
contour(X,Y,Z)

contour3(X,Y,Z)
colormap cool;