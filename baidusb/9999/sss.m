% ezplotfun

subplot(331)
ezplot('y=x^3')
subplot(332)
ezplot('y^2=x^3')
subplot(333)
ezplot('y=exp(-x^2)')
subplot(334)
ezplot('y=8/(x^2+4)')
subplot(335)
ezplot('y^2*(2-x)=x^3')
subplot(336)
%%

ezplot('3*t/(1+t^3)','3*t^2/(1+t^3)',[-0.6,30])
hold on
ezplot('3*t/(1+t^3)','3*t^2/(1+t^3)',[-30,-1.8])

%%

subplot(337)
ezplot('cos(theta)^3','sin(theta)^3')
subplot(338)
ezplot('theta-sin(theta)','1-cos(theta)',[-pi/2,6*pi/2])
subplot(339)
ezplot('x^2+y^2+x-sqrt(x.^2 + y.^2)')
axis equal
axis auto