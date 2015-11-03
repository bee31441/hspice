*SourceFollower-Sub
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

M1 vdd vg vs gnd nch w = 500n l = 200n
Vd vdd gnd dc = 0.6v
I1 gnd vs dc = 1uA sin(1uA 100nA 10k 1ns)
Vin vg gnd dc = 0.4v


.op
.tran 1us 2ms 
.end