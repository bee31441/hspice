*researchTry3.sp
.protect
.lib 'rf018.l' TT
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC=   1.0000E-12
***netlist***
Mp	inx	vb	vdd	vdd pch	w = 10u l = 0.2u
Mnw	inx	vg	vss	vss nch	w = 2.5u l = 0.2u
*Cl 	inx	eout 1p
Edc	vg	gnd	OPAMP	inx ref
*Rdc	eo	inx 1000k
*Cdc	eo	inx 1p
***output***
*E0	vo	gnd	OPAMP	inx	vo
***source***
Vd		vdd	gnd dc = 1v
Vs		vss	gnd dc = 0v
Vbias	vb	gnd dc = 0.7v
*vin		vg	gnd dc = 0.3v ac = 1
Iin	gnd inx dc = 10n

vref	ref	gnd dc = 411.3907m
***
.op
.dc iin 1n	100n	0.1n
*.ac dec 100 0.1	1000
.probe ac vdb(inx)	i(edc)	i(cdc)
.end