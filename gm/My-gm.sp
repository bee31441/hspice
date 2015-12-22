*Gm
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

*******SUBCKT************
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd  bd  bd  pch w = 2u      l = 0.4u m = 2
Min id  in  sd  sd  pch w = 2.9u    l = 0.4u m = 1
Mn  id  gg  vss vss nch w = 2.7u    l = 0.4u m = 2
.ends

*******Circuits**********
Mb  bd  vb  vdd vdd pch w = 21u     l = 1u
X1  vdd vss inp bd ggp ggp sdp gmx
X2  vdd vss inn bd ggp idn sdn gmx

*******Current Cancellation
*Mcp  ggp inn sdn sdn  pch    w = 1.9u    l = 0.4u m = 1
*Mcn  idn inp sdp sdp  pch    w = 1.9u    l = 0.4u m = 1


*******Output Load**************
E1 idn gnd OPAMP ref idn
Vr ref gnd dc = 0.5
*RL idn gnd 5k

*******Input******************
.param diff = 0
Vinp inp  gnd dc = '1+diff'
Vinn inn  gnd dc = '1-diff'

********Bias**************
Vbias   vb  gnd dc = 2.6
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0

*******
.op
.dc sweep diff -0.5 0.5 0.001
.probe dc I(e1) I(rl)
.end
