% wavedec
load sumsin; s = sumsin;
subplot(311);plot(s)

[c,l] = wavedec(s,3,'db1');
subplot(312);plot(c)


[ca9,cd9]=dwt(s,'db1');
[ca8,cd8]=dwt(ca9,'db1');
[ca7,cd7]=dwt(ca8,'db1');
cad=[ca7,cd7,cd8,cd9];
subplot(313);plot(cad)
title(['norm(cad-c)=',num2str(norm(cad-c))])