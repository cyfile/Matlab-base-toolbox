% Rosenbrock banana function
figure(213)
ezsurf('100 * (x^2 - y) ^2 + (1 - x)^2',[-1,1.5],[-0.5,2])
hold on

banana = @(x)100*(x(2)-x(1)^2)^2+(1-x(1))^2;
x0=[1.5 -0.5];
opt=optimset('PlotFcns',@optimplotx,...
    'OutputFcn', @outfun,...
    'MaxIter',60);
[x,fval,exitflag] = fminsearch(banana,x0,opt)

%%%%%%%%%%%%%%%%%%%%%%

 

function stop = outfun(x, optimValues, state)
stop = false;
cf=get(0,'currentFigure');
figure(213)
%hold on;
plot3(x(1),x(2),optimValues.fval,'r.','markersize',20);
drawnow
set(0,'currentFigure',cf)
end