***MyOp_2stage

.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1
*.option dccap=1 accurate=1 post

***param***
.param
+comon		= 0.5
+bias			= 0.6
+bias2		= 3.3
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
***netlist***
***1st stage***
Mb	b	b0	vdd	vdd	pch	W = 10u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 30u L = 0.8u m = 2
M2	2	Vinp	b		b		pch	W = 30u L = 0.8u m = 2
M5	1	b1		vss	vss	nch	W = 13u L = 0.8u m = 1
M6	2	b1		vss	vss	nch	W = 13u L = 0.8u m = 1
**low f gain = 34.5db
* for subthreshold diffpair. gain do little with Id. it is more related to Leff and Vds of output mos(about output resistance)
* gds is proportional to 1/leff & vds
*kappa ~= 0.7

***2nd stage***
m3	von	1		vdd	vdd	pch	w = 18u    l = 1u   m = 1
m4	vop	2		vdd	vdd	pch w = 3.88u 	 l = 0.4u m = 1
m7	von	von	vss	vss	nch	w = 3.8u   l = 1u   m = 1
m8	vop	von	vss	vss	nch	w = 1.1u   l = 0.4u m = 1

***compensation***

C1	z1		von 400f
Rz1	z1		1   350k
C2	2			vop 300f


***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias2


***input***
vinp vinp gnd dc = 'comon+diff' ac = 1
vinn vinn gnd dc = 'comon-diff' *ac = 1 -180






***test
*mt	vdt	vgt	vss	vss	nch	w = 2.7u   l = 0.5u m = 1
mt	vdt	vgt	vdd	vdd	pch w = 9.7u l = 0.5u m = 1

vtd	vdt	gnd dc = '1-499.7048m'
vtg	vgt	gnd dc = '1-397.6836m'

***






.op

***sweep***
.dc diff -0.5 0.5 0.01
***probe&measuring***
.ac dec 1000 10 1g
*.tf v(1) vinp
*.pz v(vop) vinp
.probe dc I(m1) I(m2)	I(mt)
.probe ac cap(von)
+gain1st=par('Vdb(2, 1)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2,1)')
*+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
.meas ac gain MAX (par('Vdb(vop)-Vdb(vinp,vinn)'))
*.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 1
*.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 1
.end
