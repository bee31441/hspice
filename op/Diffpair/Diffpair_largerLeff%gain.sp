***MyOp_2stage

.protect
.lib 'rf018.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12
*.option dccap=1 accurate=1 post

***netlist***

M1	1	Vinp	b		b		pch	W = 30u L = 0.4u m = 2
M2	2	Vinn	b		b		pch	W = 30u L = 0.4u m = 2
M5	1	b1		vss	vss	nch	W = 13.3u L = 0.4u m = 1
M6	2	b1		vss	vss	nch	W = 13.3u L = 0.4u m = 1
Mb	b	cmfb	vdd	vdd	pch	W = 10u  L = 1u	  m = 2
*low f gain = 34.5db 
* for subthreshold diffpair. gain do little with Id. it is more related to Leff and Vds of output mos(about output resistance)
* gds is proportional to 1/leff & vds 

***param***
.param 
+comon		= 0.5
+bias			= 0.6
+supplyp	= 1.0
+supplyn	= 0
+diff			= 0

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
*vocm	vocm	gnd dc comon 
vb 		cmfb	gnd dc bias *ac = 1 
vb1		b1		gnd dc = 0.3
vb2		b2		gnd dc = 0.5
vb3		b3		gnd dc = 0.3

***input***
vinp vinp gnd dc = 'comon+diff' ac = 1
vinn vinn gnd dc = 'comon-diff' ac = 1 180

.op

***sweep***
*.dc diff -0.5 0.5 0.01
***testing***
*.dc vtd 0.2 0.4 0.01 *sweep wnt 1u 20u 200n

***probe&measuring***
.ac dec 1000 10 1g
.pz v(2) vinp
.probe dc I(mt) I(m1) I(m2)	par('v(3)-v(4)')
.probe ac gain=par('Vdb(2, 1)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase=par('vp(2,1)')


.end
