*filter
.protect
.lib 'rf018.l' TT
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC=   1.0000E-12
***netlist***

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
C1	z1	von 1000f
Rz1	1		z1 1k
C2	2	vop 900f

Cl2	2	gnd 300f
Cb	b	gnd 1000f	
.ends

XOP1	vdd	vss	vinn	vinp	vop		b0	b1	OP
*Eop		vop	gnd	OPAMP	vinp	vinn
Ci	vinn 	vop   2.2p
*Cd	vop		gnd  220p

*XOP2	vdd	vss	vinn2	vinp2	vout	b0	b1	OP
*Cfd	vinn2	vout  2.2p
*Rd	vinn2	vout  47k

***param***
.param 
+bias			= 0.6
+bias2		= 0.3
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias2
v1		vinp	gnd dc = 0.5
v2		vinp2	gnd dc = 0.5
***source***
Vd		vdd	gnd dc = 1v
Vs		vss	gnd dc = 0v
Vbias	vb	gnd dc = 0.7v
*vin		vg	gnd dc = 0.3v ac = 1
.param f = 320k
*Iin	gnd vinn ac = 1 sin(20n 10n f 1ns)
*Rin	vinn	gnd 10x
***By thevanin
vin	inx	gnd	dc = 0 ac = 1
Rin	 vinn	inx 10x

***
.op
*.dc iin 1n	100n	0.1n
.ac dec 100 0.01	100000g
.pz v(vop) iin
*.tran 10ns 100u sweep f 310k 330k 10k
.probe i(cd) vdb(vop)
.end