*ClassABgm_b
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1

***netlist***

M1 sn vx   vdd vdd pch w = 5u l = 0.4u m = 3
M3 vx vinp sn  sn  pch w = 12u  l = 0.4u m = 1
M2 sp vx   vdd vdd pch w = 5u l = 0.4u m = 3
M4 vx vinn sp  sp  pch w = 12u  l = 0.4u m = 1
Mb  vx vb   vss vss nch w = 15u  l = 1u m = 3

Min ion vinn sn sn pch  w = 1.7u l = 0.4u m = 1
Mip iop vinp sp sp pch  w = 1.7u l = 0.4u m = 1

Mc1 ion ion vss vss nch w = 1.1u l = 0.4u m = 6
Mc2 iop iop vss vss nch w = 1.1u l = 0.4u m = 6

***source***
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
Vbi vb   gnd dc = 0.5

.param diff = 0
Vip vinp gnd dc = '2.2-diff'
Vin vinn gnd dc = '2.2+diff'

*En ion gnd OPAMP vref ion
*Ep iop gnd OPAMP vref iop
*.param rr = 0.4
*Vr vref gnd dc = rr

***
.op
.dc sweep diff -0.5 0.5 0.001 *sweep rr 0.6 1.6 0.2
.probe dc lx3(M3) lx3(M1) lx2(M3) lx2(M1) lx2(mip)
*+ I(en), I(ep) Idiff = par('I(ep)-I(en)')
+ Vdiff = par('V(iop) - V(ion)') I(mc1) I(mc2) Idiff = par('I(mc2)-I(mc1)')
.end
