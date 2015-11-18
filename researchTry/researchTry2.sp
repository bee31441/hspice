*researchTry2.sp
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1	DCON=1
***netlist***
*.subckt ct vdd vss v1 vb vI vo

***Derivator & Unit gain Buffer***

.param Rzv = 10x
C1 inx aco 100f
E1 aco gnd VCVS ref1 inx 1000
Vr1 ref1 gnd dc = 0
Rz inx gnd Rzv
Cl aco gnd 20p

R3 aco 2- 500G
C2 aco 2- 25f
E2 dco gnd VCVS ref2 2- 1000
Vr2 ref2 gnd dc = 0
C3 2- dco 10p

R1 dco1 3- 300k
E3 3o gnd VCVS ref3 3- 1000
Vr3 ref3 gnd dc = 0
R2 3o 3- 3000k
Rdc inx 3o 450x

Ef		vin	gnd	VCVS	dco gnd 1000
Ibias	gnd inx1 dc = 12n  pulse(10n 12n 10ns 1ns 1ns 48ns 100ns)
G1		inx1	gnd	VCCS	vin	gnd	10^-8


*I1 gnd inx ac = 1
vdco dco1 gnd ac = 1



Et	vt	gnd	VCVS	vtr1	gnd	1000
vx	vtr gnd dc = 0.5
Rti	vtr	vtr1 100
Rt	vt	gnd	1000k

.op
*.dc in 0.1u 0.2u 0.01u 
*.dc ibias 11u 10u 0.1u
.ac dec 20 0.001 1000k 
*.tran 1ns 100ns
.pz v(dco) Vdco 
.probe ac vdb(dco)
.probe tran I(ibias) 
.end