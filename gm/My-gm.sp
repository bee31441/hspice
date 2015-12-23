*Gm
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1
***netlist***

*******SUBCKT************
.subckt gmx vdd vss vb2 in bd gg id sd
Ms  sd  vb2  bd  bd  pch w = 4u    l = 0.4u m = 1
Min id  in  sd  sd  pch w = 25u    l = 0.4u m = 1
Mn  id  gg  vss vss nch w = 11u    l = 0.4u m = 2
.ends

*******Circuits**********
Mb  bd  vb  vdd vdd pch w = 21u     l = 1u   m = 2
X1  vdd vss vb2 inp bd ggp idp sdp gmx
X2  vdd vss vb2 inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
*******Current Cancellation
Mbp  bump     inp     x   x  pch    w = 1u    l = 0.4u m = 1
Mbn  vss   inn    bump   bump   pch    w = 1u    l = 0.4u m = 1
Vx bd x dc = 0.1

*******Output Load**************
*E1 idn gnd OPAMP ref idn
*Vr ref gnd dc = 0.4
*RL idn gnd 5k

*******Input******************
.param diff = 0
Vinp inp  gnd dc = '1.3+diff'
Vinn inn  gnd dc = '1.3-diff'

********Bias**************
Vbias   vb  gnd dc = 2.7
Vbias2  vb2 gnd dc = 1.4
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0

*******
.op
.dc sweep diff -0.5 0.5 0.001
.probe dc I(e1) I(rl) Idiff = par('I(X1.mn)-I(X2.mn)') Ip = par('I(x1.mn)') In = par('I(x2.mn)') I(mbp)
.end
