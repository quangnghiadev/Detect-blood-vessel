 function Ldia=low_diamond(order)

format long;
p00 = fir1(order, .5);%FIR1(order, .5);
b0=p00'*p00;
c0=b0+minus1topower(b0);
d0=quin1(c0);
Ldia=d0;
