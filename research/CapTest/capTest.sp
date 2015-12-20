*CapTest
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1
***netlist***

Mn vdn vgn vsn vsn nch w = 10u l = 0.4u

vnd vdn gnd dc = 1v
vng vg gnd dc = 1v pulse(0.7 1 1ms 1ms 1ms 1s 2s)
vns vsn gnd dc = 0v

Rl vg vgn 10k
Cl vgn gnd 3u

.op
.tran 10us 5s
.probe tran I(mn)
.end
