*Current
*This is a file taht shouldn't include long ternm stored info
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

.param wx = 2.9u
+ lx = 0.4u
*Mp vss vbp vdp vdp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(1.035u, 21u/1u, 1, 0.9, 0.7)
*Mp vdp vbp vdp vdp pch w = wx l = lx m = 2  * (Id, w/l, m, vds, vgs)=(496.8n, 2u/0.4u, 2, 0.7, 0.7)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(504n, 3.2u/0.4u, 1, 1, 0.7)
Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(507n, 2.9/0.4u, 1, 1.2, 0.7)
*Mn  vgn vgn vsn vsn nch w = wx l = lx m = 2  * (Id, w/l, m, vds, vgs)=(495.2n, 2.7u/0.4u, 2, 0.5, 0.5)

Vpd vdp gnd dc = 0.5
Vps vsp gnd dc = 1.7
vpg vgp gnd dc = 1
Vnd vdn gnd dc = 0.7
Vns vsn gnd dc = 0
vng vgn gnd dc = 0.5


***
.op
.dc wx 0.4u 3u 0.1u
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdd)-v(vbp)') I(mn) i(mp)
*.print dc par('1/lx8(mp)') par('-I(mp)')
.end
