*hw1-1
.protect
.lib 'cic018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 



***2.6netlist***
.SUBCKT h2_6b vd vg vs 
M1 vd vg vs vs n_18 W=1u L=500.0n 
R1 vd vg 2k
R2 vg vs 4k
.ends
.SUBCKT h2_6e vd vg vs
M1 vd vg vs vs n_18 W=1u L=500n 
R1 vd vg 2k
.ends

.SUBCKT h2_7 vd vg vs
M1 vd vg vs vs n_18 W=1u L=500n 
R1 vd gnd 20k
.ends

.SUBCKT h3.16a vd vg vs
M1 vd vg gnd gnd n_18 W=1u L=500n 
M2 vd vb vdd vdd p_18 W=3u L=500n
R1 vdd vd 1000k
.ends

.SUBCKT h3.16c vd vg vs
M1 vd vg gnd gnd n_18 W=1u L=500n 
M2 vd vb vdd vdd p_18 W=3u L=500n
R1 vdd vb 1k
R2 vb vd 1k
.ends

.SUBCKT h3.18c vd vg vs
M1 vd vg vs vs n_18 W=1u L=500n 
Rd vdd vd 1k
Rs vs gnd 1k
.ends

*.SUBCKT h3.19b vd vg vs
M2 vd vg vs vs n_18 W=1u L=500n 
M3 vd vb vdd vdd p_18 W=3u L=500n
M1 vs vb2 gnd gnd n_18 W=1u L=500n
Rs vs gnd 5k
*.ends

 
*Xh2_7 vd vg vs h2_7 
vx vs gnd 3.5v
vddd vdd gnd 3v
vb3 vb gnd 2.3v
vb2 vb2 gnd 0.5v
vb1 vg gnd 1v 



.op
.dc sweep vx 0 5 0.05 
.probe dc lx7(m1) lx4(m1) I(rs)
.probe Ix=par('lx4(m1)-lx4(m2)')


.END
