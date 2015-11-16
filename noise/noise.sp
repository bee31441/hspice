*noise
.protect
.lib 'rf018.l' TT
*.lib 'cic018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 
***netlist***

.param wp = 1.2u wn = 400n
*m1 vdd vg vss vss nch w = wn l = 200n
*m2 vss vg vdd vdd pch w = wp l = 200n


 *****************diode connect********************
m1 vss vss idd idd pch w = 1.2u l = 200n 
.param Idc = 1000n
*ix idd gnd dc = '-Idc' ac = 1
Vind idd gnd dc = 1v ac = 1

*****************stack mos************************
*m4 in vb1 1 1 nch w = wn l = 200n
*m5 1 vb2 vss vss nch w = wn l = 200n
*vbias1 vb1 gnd dc = 0.7v
*vbias2 vb2 gnd dc = 0.5v
*Iin in gnd dc = 500u
****************ideal stuff****************
*HX 20 gnd VCUR MAX=+10 MIN=-10 100000
*vcur 1 gnd  dc = 0v
*Iin 1 gnd dc = 100n
*R1 20 gnd 10k
*.probe v(20)



vd vdd gnd dc = 0.2v
vs vss gnd dc = 0v

vin vg gnd dc = 0.3v
.op
.dc vind 0 1 0.01
*.print lx18(m1) 
*+Qg = par('lx14(m1)') *GateCharge
*+lx32(m1) 
*+CAP_BS	= par('lx28(m1)')
*+CAP_BD	= par('lx29(m1)')
*+gm			= par('lx7(m1)')
*+gds		= par('lx8(m1)')
.probe I(m1) lx18(m1) gds=par('lx8(m1)')
*.dc sweep wp 1u 3u 50n
*.dc sweep Iin 10n 500n 1n
*.probe I(m1) I(m2)

.ac dec 20 1 100  sweep vind  0 1 0.2
.noise I(m1) vind 10
.end

