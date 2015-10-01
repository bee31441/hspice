*OTA
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1

* pmos: u0Cox /= 8.6e-5
* nmos: /= 2.0718e-5

XWLR_outter vdd vss wgn wgp iout WLR_outter 
XWLR_innerp vdd vssp winp wgp ib WLR_inner
XWLR_innern vdd vssn winn wgn ib WLR_inner
Mb ib vb vdd vdd pch w = 2.6u l = 200n
Xbump ib vssb wgp wgn bump


.subckt WLR_outter vdd vss inn inp iout
M1 1d 1d vdd vdd pch w = 1.2u l = 200n m = 2
M3 iout 1d vdd vdd pch w = 1.2u l = 200n m = 2
M2 1d inn vss vss nch w = 400n l = 200n m = 2
M4 iout inp vss vss nch w = 400n l = 200n m = 2
.ends

.subckt WLR_inner vdd vss win wg ib
Ms sd sd ib ib pch w = 1.2u l = 200n
Mw wg wg sd win pch w = 1.2u l = 200n
Mgm wg wg vss vss nch w = 400n l = 200n
.ends

.subckt bump ib vss wgp wgn 
Mb1 ib wgn 1 vss nch w = 400n l = 200n m = 4
Mb2 1 wgp vss vss nch w = 400n l = 200n m = 4
.ends

.param vd = 1.8v
Vd vdd gnd dc = vd
vs vss gnd dc = 0v
Vsp vssp gnd dc = 0v
Vsn vssn gnd dc = 0v
vsb vssb gnd dc = 0v
vbias vb gnd dc = 'vd - 0.3v' pulse('vd - 0.3v' 0v 1ns 1ns 1ns 40ns 100ns)

.param vdc = 'vd/2' diff = 0.5 vdiff = 1.4v
Vinp winp gnd dc = 'vdc + vdiff/2' ac = diff
*Vinn winn gnd dc = 'vdc - vdiff/2 ' ac = -diff
Vinn winn gnd dc = 0.9

***Iout measure***
*HX 20 gnd VCUR MAX=+10 MIN=-10 100000
*vcur iout gnd  dc = 0v
*R1 20 gnd 10k
******************
.op
.dc sweep vdiff '0' vd 0.01
*.ac dec 500 1k 1Meg *sweep vbias 0.8 1.2 0.05
.tran 1ns 300ns 
.probe Idiff = par('I(vsn)-I(vsp)')  
.probe dc I(mb)  I(XWLR_innerp.Mgm) 
*.probe  isub(xbump.ib)
.print dc Idiff = par('I(vsn)-I(vsp)') 
*+ v(20)    *Use the current controlled voltage source(H Element) ouput to sense current(x E5)
.end

*Need to ask how to calculate the cap charging time

