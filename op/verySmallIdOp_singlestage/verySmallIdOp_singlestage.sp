***MyOp_2stage

.protect
.lib 'rf018.l' tt
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC=1.0000E-12

***netlist***
***1st stage***
M1	1	Vinp	b		b		pch	W = 2.9u L = 0.2u m = 2
M2	2	Vinn	b		b		pch	W = 2.9u L = 0.2u m = 2
M5	1	b1		vss	vss	nch	W = 1.8u L = 0.2u m = 1
M6	2	b1		vss	vss	nch	W = 1.8u L = 0.2u m = 1
Mb	b	cmfb	vdd	vdd	pch	W = 10u  L = 1u	  m = 4

***2nd stage***


***param***
.param 
+comon		= 0.5
+bias			= 0.7
+supplyp	= 1.0
+supplyn	= 0
+diff			= 0

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
*vocm	vocm	gnd dc comon 
vb 		cmfb	gnd dc bias 
vb1		b1		gnd dc = 0.3

***input***
vinp vinp gnd dc = 'comon+diff' ac 0.5
vinn vinn gnd dc = 'comon-diff' ac -0.5

***output***


*mt	vdt	vgt	vdd	vdd	pch	w = 10u l = 1u m = 4 *vgs=0.3: (vds, id) = (0.6, 97.6n)(0.2, 93.6n)
.param wp = 2.9u wn = 1u
*mt	vdt	vgt	vdd	vdd	pch	w = wp l = 0.2u m = 2  *vgs=0.3: (vds, id) = (0.6, 47n)(0.2, 37.2n)
mt	vdt	vgt	vss	vss	nch	w = wn l = 0.2u
vtg	vgt	gnd dc = 0.3v
vtd	vdt	gnd dc = 0.2v

.op

***sweep***

***testing***
.dc diff -0.5 +0.5 0.01
***probe&measuring***
.ac dec 10 10 1g
.pz v(2) vinp
.probe dc I(mt) I(m1) I(m2)


.end
