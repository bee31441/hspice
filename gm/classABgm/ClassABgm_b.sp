*ClassABgm_b
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1

***netlist***

M1n sn vx   vdd vdd pch w = 5u l = 0.4u m = 3
M3n vx vinp sn  sn  pch w = 12u  l = 0.4u m = 1
M2n sp vx   vdd vdd pch w = 5u l = 0.4u m = 3
M4n vx vinn sp  sp  pch w = 12u  l = 0.4u m = 1
Mb  vx vb   vss vss nch w = 15u  l = 1u m = 3

Min ion vinn sn sn pch  w = 2.8u l = 0.4u m = 1
Mip iop vinp sp sp pch  w = 2.8u l = 0.4u m = 1

***source***
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
Vbi vb   gnd dc = 0.5

.param diff = 0
Vip vinp gnd dc = '2.2-diff'
Vin vinn gnd dc = '2.2+diff'

En ion gnd OPAMP vref ion
Ep iop gnd OPAMP vref iop
Vr vref gnd dc = 1.65

***
.op
.dc sweep diff -0.5 0.5 0.001
.probe I(en), I(ep) Idiff = par('I(ep)-I(en)') lx3(m3n) lx3(m1n) lx2(m3n) lx2(m1n) lx2(mip)
.end
