% ezpolarfun

subplot(331)

%%
ezpolar('psi',[0,11])
%%

subplot(332)
%%
ezpolar('exp(.1*phi)',[0,13])
%%

subplot(333)
%%
ezpolar('10/phi',[1,20])
%%
subplot(334)
ezpolar('sqrt(sin(2*theta))')
subplot(335)
ezpolar('sqrt(cos(2*theta))')
subplot(336)
ezpolar('cos(3*phi)')
hold on
ezpolar('sin(3*phi)')

subplot(337)
ezpolar('1-cos(phi)')
subplot(338)
ezpolar('cos(2*phi)')
subplot(339)
ezpolar('sin(2*phi)')