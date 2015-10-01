*CF
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB INGOLD=1 ACCURATE=1

* pmos: u0Cox /= 8.6e-5
* nmos: /= 2.0718e-5

vd vdd gnd dc = 3.3v
Ibias vdd Di dc = 100u
R1 Di Si 10k
Vin vgin gnd dc = 1v 
*Iin sout gnd dc = 100n pulse(100nA 200nA 1us 1us 1us 500us 1000us)  
Iin sout gnd dc = 1uA sin(1uA 100nA 1000 2ns)
E1 n- gnd OPAMP Di n-
E2 Si gnd OPAMP Sout Si 
M1 n- vgin Sout Sb nch w = 1.2u l = 200n
Vbody sb gnd dc = 0v

*.ic v(sout) = 0v v()

*****try unit gain buffer*****
*Et 1 gnd OPAMP 2 1
*Vt 2 gnd dc = 1v
*rt 1 gnd 1k
*****try current source*******
*it vdd 1 dc = 1mA
*rt 1 gnd 1k


***Iout measure***
*HX 20 gnd VCUR MAX=+10 MIN=-10 100000
*vcur iout gnd  dc = 0v
*R1 20 gnd 10k
******************
.op
*.dc sweep it 0v 1v 0.1v
*.probe I(rt) V(1)
.dc Iin 1uA 100uA 1uA 
.tran 1us 2000us  sweep Vbody 0v 1v 0.5v
.meas tran Maxamplitude Max V(sout)
.meas tran Minamplitude Min V(sout)
.meas tran amplitude param = ('Maxamplitude - Minamplitude')
.probe V(sout) I(iin) lx7(m1)
.end


