*Drain Source Conductance
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

Mp vss vbp vdd vdd pch w = 20u l = 1u m = 1

Vd 	vdd	 gnd dc = 2v
Vs vss gnd dc = 1v
vIbias vbp gnd dc = 0.7v



***
.op
.dc vIbias 2v 0v 0.001
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdd)-v(vbp)')
.end