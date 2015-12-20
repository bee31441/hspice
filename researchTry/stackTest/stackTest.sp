*stacktest
.protect
.lib 'rf018.l' TT
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC= 1.0000E-12  unwrap = 1
+captab = 1 
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
C1	z1		von 400f
Rz1	z1		1   350k
C2	2			vop 900f
.ends

***netlist***
Mp	inx	vb	vdd	vdd pch	w = 11u l = 0.2u    
Ibi vdd	vdnw dc = 86.0773n ac = 1
Mnw	vdnw	vg	vss	vss nch	w = 2.5u l = 0.2u
Ms	inx	b3	vdnw	vdnw	nch w = 2.5u l = 0.2u
XOPf	vdd	vss	vinn	vinp	vop	b0	b1	OP






***param***
.param 
+bias			= 0.6
+bias2		= 0.3
+bias3		= 0.6
***connection source***
vx		vinp	inx dc = 0		*OPf input and inx
vy		vop		vg  dc = 0		*Opf output and NW_Vg

***source***
Vd		vdd	gnd dc = 1v
Vs		vss	gnd dc = 0v
Vbias	vb	gnd dc = 0.7v		*Pmos for bias current
vb 		b0		gnd dc bias		*OP bias1
vb1		b1		gnd dc bias2	*Op bias2
vb3		b3		gnd dc bias3

vref	vinn	gnd dc = 0.5



***
.op
.dc ibi dec 10 1n	10u
.ac dec 100 0.1	1000g *sweep rr poi 3 1x 10x 1g
.probe ac vdb(inx) vdb(vg) i(mnw) 
.probe dc i(mnw) lx8(mnw) lx8(ms) i(ms) rdsenl = par('lx7(ms)/lx8(ms)')
.end                     
