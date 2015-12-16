*researchTest.sp
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

Mp vss vbp vdd vdd pch w = 30u l = 10u m = 3

Vd vdd gnd dc = 3.3v
Vs vss gnd dc = 0v
.param vIb = 0.7v
vIbias vbp vss dc = 0.3



***Derivator & Unit gain Buffer***
*E1 vcin gnd OPAMP vo vcin  MAX=2 MIN=0 1000		*unit gain buffer

R vdd vss .22k


***
.op
.dc vs 3.3 0 0.01
.print lx6(mp)
.end