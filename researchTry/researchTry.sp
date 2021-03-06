*researchTry.sp
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***
*.subckt ct vdd vss v1 vb vI vo
Mb vo vb v1 vss nch w = 10u l = 200n
Md vo vI vdd vdd pch w = 40u l = 200n
*.ends
*X1 vdd vss v1 vb vI vo ct
M6 v1 vin vss vbin nch w = 8u l = 200n			*Nanowire
Vconcentration vbin gnd dc = 0v
Vd vdd gnd dc = 1v
Vs vss gnd dc = 0v
.param vIb = 0.7v
vbias vb vss dc = '1 - vIb + 0.5'
vIbias vI vss dc = vIb
.param inb = '1 - vIb'  *123
+ampt = 0.01
Vin vin gnd dc = inb pulse('inb - ampt/2' 'inb + ampt/2' 1ns 0.1ms 0.1ms 0ms 0.2ms)

***Derivator & Unit gain Buffer***
*E1 vcin gnd OPAMP vo vcin  MAX=2 MIN=0 1000		*unit gain buffer
v0 vcin vo dc = 0v
E2 vout gnd OPAMP b+ in- MAX=2 MIN=-2 1000				*derivaotr op
vEb b+ gnd 0v
C1 vcin in- 0.1p 
R1 vout in- 1000000k

***Mos Size Test***
.param ww = 40u
M1 vdt vgt gnd vwt nch w = 9u l = 200n
vtd vdt gnd dc = 0.5v 
vtg vgt gnd dc = 0.6v
vtw vwt gnd dc = 0v
M2 vdt2 vgt2 vst2 vst2 pch w = ww l = 200n
vts2 vst2 gnd dc = 1v
vtd2 vdt2 gnd dc = 0.25v 
vtg2 vgt2 gnd dc = 0.7v
 ***Derivator Test***
Et1 1 gnd OPAMP 2 3
vtEb 2 gnd 0v
Ct1 vto 3 0.1n 
Rt1 1 3 1000k
Vtin vto gnd dc = 0v pulse(0.5 -0.5 1ns 1ms 1ms 0ms 2ms)
*Itin gnd vto dc = 0u pulse(0.2u -0.2u 1ns 0.5ms 0.5ms 0ms 1ms)

***
.op
.dc sweep vtd 0 5v 0.1v
*.dc sweep ww 0.5u 50u 0.5u
.tran 0.1ms 0.3ms 10us *sweep Vconcentration 0 0.2 0.05
.probe dc I(M1) I(M2) 
.probe tran I(C1) I(M6) vglitch=par('V(vcin) - V(vo)')
.print tran I(c1)
*.tran 1us 2ms 
.end