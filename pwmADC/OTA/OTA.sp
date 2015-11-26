*OTA
.option brief = 1
*.protect
.lib 'rf018.l' TT
*.unprotect
.option brief = 0
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1

* pmos: u0Cox /= 8.6e-5
* nmos: /= 2.0718e-5

XWLR_outter	vdd	vssno	vsspo	wgn	wgp	iout	WLR_outter	wp = 1u	wn = 400n	mp = 2	mn = 2
XWLR_innerp	vdd	vssp	winp	wgp	ib	WLR_inner	wp = 1u wn = 400n	mp = 1 mn = 1
XWLR_innern vdd	vssn	winn	wgn	ib	WLR_inner	wp = 1u wn = 400n	mp = 1 mn = 1
Mb	ib vb vdd vdd pch w = 2u l = 200n
Xbump	ib	vssb	wgp		wgn	bump	wn1 = 400n wn2 = 400n	m1 = 4 m2 = 4


.subckt	WLR_outter	vdd	vssno	vsspo	inn	inp	iout	wp = 1.2u wn = 400n	mp = 2 mn = 2
M1 1d 1d vdd vdd pch w = wp l = 200n m = mp
M3 iout 1d vdd vdd pch w = wp l = 200n m = mp
M2 1d inn vssno vssno nch w = wn l = 200n m = mn
M4 iout inp vsspo vsspo nch w = wn l = 200n m = mn
.ends

.subckt WLR_inner vdd vss win wg ib	wp = 1.2u wn = 400n	mp = 1 mn = 1
Ms sd sd ib ib pch w = wp l = 200n	m = mp
Mw wg wg sd win pch w = wp l = 200n	m = mp
Mgm wg wg vss vss nch w = wn l = 200n	m = mn
.ends

.subckt bump ib vss wgp wgn wn1 = 400n wn2 = 400n	m1 = 4 m2 = 4
Mb1 ib wgn 1 vss nch w = wn1 l = 200n m = m1
Mb2 1 wgp vss vss nch w = wn2 l = 200n m = m2
.ends




.param vd = 1.8v
Vd vdd gnd dc = vd
*vs vss gnd dc = 0v
Vsp vssp gnd dc = 0v
Vsn vssn gnd dc = 0v
vsb vssb gnd dc = 0v
Vsno	vssno	gnd	dc = 0v
Vspo	vsspo	gnd	dc = 0v
vbias vb gnd dc = 'vd - 0.3v' pulse('vd - 0.3v' 0v 1ns 1ns 1ns 40ns 100ns)

.param 
+vdc = 'vd/2'	
+diff = 0.5	
+vdiff = 1.4v	
+diff_a = 1

Vinp winp gnd dc = 'vdc + vdiff/2' ac = diff_a
Vinn winn gnd dc = 'vdc - vdiff/2 '*ac = '-diff_a'
*Vinn winn iout dc = 0
*Cl iout gnd 1p

***Iout measure***
.param ro = 1x
vout	iout	gnd	dc = 0.9
*E1	gnd	vout	OPAMP	vr	iout
*Ro1	iout	gnd	ro
*Ro2	vout	gnd ro
*E2	vr	gnd		VCVS	iout	gnd	1
*HX 20 gnd VCVS MAX=+10 MIN=-10 100000
*vcur iout gnd  dc = 0v
*R1 20 gnd 10k
******************
.op
.dc vdiff '-vd' 'vd' 0.01 *sweep ro 1x 3x 1x
.ac dec 10 1 1Meg 
.tran 1ns 300ns 
.probe dc I(mb) i(vout)
+I(XWLR_outter.M3) I(XWLR_outter.M4) I(XWLR_innerp.Mgm) Ienlarge_p = par('I(XWLR_outter.M4)/I(XWLR_innerp.Mgm)')
+I(XWLR_outter.M1) I(XWLR_outter.M2) I(XWLR_innern.Mgm) Ienlarge_n = par('I(XWLR_outter.M2)/I(XWLR_innern.Mgm)')
+Idiff_inner = par('I(vsn)-I(vsp)')	
+Idiff_outter = par('I(vsno)-I(vspo)')
+IoutIb = par('Idiff_outter/I(Mb)')
.probe ac I(mb) I(XWLR_innerp.Mgm) vdb(iout)
.pz V(iout)	vinp

*.probe  isub(xbump.ib)
*+ v(20)    *Use the current controlled voltage source(H Element) ouput to sense current(x E5)
.end

*Need to ask how to calculate the cap charging time

