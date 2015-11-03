*CurrentMirror.sp
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
*.12
*toxp=toxn = 4.08*10-9m	er*e0 = 34.5306e-12F/m Coxn=Coxp = 8.46e-3F/m^2
*u0n = 0.0398 m^2/Vs	u0p = 6.8583350E-03
*kn = 33.631e-5	kp = 5.8e-5
*nVe = -1.6940	pVe = -2.21
M1	vn		vbn 	vss	vss nch w = 500n l = 200n
M1n vbp2	vbn2	vn	vss nch w = 500n l = 200n
M2	vbn		vbn		vss vss nch w = 500n l = 200n m = 1
M2n vbn2	vbn2	vbn vss nch w = 500n l = 200n m = 1
M3	vbp		vbp 	vdd vdd pch w = 800n l = 200n m = 4
M3p	vbp2	vbp2	vbp	vbp pch w = 800n l = 200n m = 4
M4p	vbn2	vbp2	vp	vp	pch w = 800n l = 200n m = 4
M4	vp		vbp		vdd vdd pch w = 800n l = 200n m = 4

RL vL vss 5000k

vd vdd gnd dc = 1
vs vss gnd dc = 0
*Vpb vbp gnd dc = 0.4
*Vnb vbn gnd dc = 0.6 

***Test mos***
.param ww = 1u
Mt1 vtd vtg vts vtw pch w = ww l = 200n 
Vdt vtd gnd dc = 0
Vgt vtg gnd dc = 0.25
vst vts gnd dc = 0.5v
vwt vtw gnd dc = 0v


.op
.dc sweep vs 1 0 0.01
.dc sweep ww 500n 1.2u 10n
.probe I(m1) I(m2)
.probe I(mt1)
.end