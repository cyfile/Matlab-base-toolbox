% solvepoly

clear
syms x a b c d l h
y=a*x^3 + b*x^2 + c*x + d;
dy=diff(y);
[a,b,c,d]=solve([char(subs(y,x,0)),'=0'],...
                 [char(subs(dy,x,0)),'=0'],...
                 subs(y,x,-l)-h,...
                 subs(dy,x,-l),'a','b','c','d');