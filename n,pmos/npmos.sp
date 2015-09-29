*n,pmos
.protect
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 
***netlist***

.param wp = 1.2u wn = 400n
*m1 vdd vg vss vss nch w = wn l = 200n
*m2 vss vg vdd vdd pch w = wp l = 200n

 *****************diode connect********************
*m3 vss vss idd idd pch w = 1.2u l = 200n 
*ix idd gnd dc = -100n

*****************stack mos************************
*m4 in vb1 1 1 nch w = wn l = 200n
*m5 1 vb2 vss vss nch w = wn l = 200n
*vbias1 vb1 gnd dc = 0.7v
*vbias2 vb2 gnd dc = 0.5v
*Iin in gnd dc = 500u
****************ideal stuff****************
HX 20 gnd VCUR MAX=+10 MIN=-10 100000
vcur 1 gnd  dc = 0v
Iin 1 gnd dc = 100n
R1 20 gnd 10k
.probe v(20)



*vd vdd gnd dc = 1.8v
*vs vss gnd dc = 0v

*vin vg gnd dc = 1.4v
.op
*.dc sweep wp 1u 3u 50n
.dc sweep Iin 10n 500n 1n
*.probe I(m1) I(m2)

.end

