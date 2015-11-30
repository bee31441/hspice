*n,pmos
.protect
.lib 'rf018.l' TT
*.lib 'cic018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 
***netlist***

.param wp = 1.2u wn = 700n
m1 d g vss vss nch w = wn l = 200n
R1 vdd	d 10x

vd vdd gnd dc = 0.5v
vs vss gnd dc = 0v

vin g gnd dc = 0.3v ac = 1
.op
.dc vd 0 0.9v 0.01
.ac dec 100 1	100g 
.probe I(m1)
.pz	v(d)	vin
.end

