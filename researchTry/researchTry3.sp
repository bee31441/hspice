*researchTry3.sp
.protect
.lib 'rf018.l' TT
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC=   1.0000E-12
***OP***
.subckt	OP	vdd	vss	vinn	vinp	vop	b0	b1	
Mb	b	b0		vdd	vdd	pch	W = 10u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 30u L = 0.4u m = 2
M2	2	Vinp	b		b		pch	W = 30u L = 0.4u m = 2
M5	1	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
M6	2	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
m3	von	1		vdd	vdd	pch	w = 18u    l = 1u m = 1
m4	vop	2		vdd	vdd	pch w = 17.83u l = 1u m = 1
m7	von	von	vss	vss	nch	w = 3.8u   l = 1u m = 1	
m8	vop	von	vss	vss	nch	w = 3.7u   l = 1u m = 1
C1	1	von 800f
C2	2	vop 800f
.ends

***netlist***
Mp	inx	vb	vdd	vdd pch	w = 11u l = 0.2u
Mnw	inx	vg	vss	vss nch	w = 2.5u l = 0.2u
Cl 	inx	v0  10f
R1	inx	v0  0.5g
V00	v0	gnd dc = 0 

*cx	vg inx 1p
XOPf	vdd	vss	vinn	vinp	vop	b0	b1	OP

*** BandPass***
XOP1	vdd	vss	vinn1	vinp1	vop1		b0	b1	OP
Ci	vinn1 	vop1   2.2p
Cd	vop1		vinn2  220p

XOP2	vdd	vss	vinn2	vinp2	vout	b0	b1	OP
Cfd	vinn2	vout  2.2p
Rd	vinn2	vout  47k
v1		vinp1	gnd dc = 0.5
v2		vinp2	gnd dc = 0.5


***output***



***param***
.param 
+bias			= 0.6
+bias2		= 0.3

***connection source***
*Vw vinn1	inx dc = 0v			*Bandpass and inx
vx		vinp	inx dc = 0		*OPf input and inx
vy		vop		vg  dc = 0		*Opf output and NW_Vg

***source***
Vd		vdd	gnd dc = 1v
Vs		vss	gnd dc = 0v
Vbias	vb	gnd dc = 0.7v		*Pmos for bias current
vb 		b0		gnd dc bias		*OP bias1
vb1		b1		gnd dc bias2	*Op bias2
vref	vinn	gnd dc = 0.5
*vin		vg	gnd dc = 0.3v ac = 1
.param f = 320k
Iin	gnd inx dc = 50n ac = 1 sin(20n 10n f 1ns)

***
.op
.dc iin 1n	100n	0.1n
.ac dec 100 10	100000g
.probe ac vdb(inx) vdb(vg)
.pz v(inx) iin
.tran 10ns 100u sweep f 310k 330k 10k
.end