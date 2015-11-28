*researchTry3.sp
.protect
.lib 'rf018.l' TT
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC=   1.0000E-12
***netlist***
Mp	inx	vb	vdd	vdd pch	w = 11u l = 0.2u
Mnw	inx	vg	vss	vss nch	w = 2.5u l = 0.2u
*Cl 	inx	eout 1p

*Rdc	eo	inx 1000k
*Cdc	eo	inx 1p
***output***

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
.ends

XOPf	vdd	vss	vinn	vinp	vop	b0	b1	OP
.param 
+bias			= 0.6
+bias2		= 0.3
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias2
vref	vinn	gnd dc = 0.5	*496.3104m
v1		vinp	inx dc = 0
v2		vop		vg  dc = 0


***source***
Vd		vdd	gnd dc = 1v
Vs		vss	gnd dc = 0v
Vbias	vb	gnd dc = 0.7v
*vin		vg	gnd dc = 0.3v ac = 1
Iin	gnd inx dc = 10n

***
.op
.dc iin 1n	100n	0.1n
*.ac dec 100 0.1	1000
.probe ac vdb(inx)
.end