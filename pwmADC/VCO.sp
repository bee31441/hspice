*Voltage Controlled Oscillator
.protect
.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1




.subckt Schimmit vdd vss In Out 
Ms1p s1pd In vdd vdd pch w = 1.2u l = 360n
Ms2p Out In s1pd s1pd pch w = 1.2u l = 360n
Ms1n Out In s1ns s1ns nch w = 400n l = 360n
Ms2n s1ns In vss vss nch w = 400n l =360n

Ms3p vss Out s1pd s1pd pch w = 400n l = 360n
Ms3n vdd Out s1ns s1ns nch w = 400n l = 360n
.ends

.subckt inverter vdd vss in out
M1 out in vdd vdd pch w = 2.3u l = 0.5u
M2 out in vss vss nch w = 1u l = 0.5u
.ends

.subckt VCO_amp vdd vss in out vf
M6 1 1 vdd vdd pch w = 1.2u l = 360n
M5 1 in vss vss nch w = 400n l = 360n 

M4 2 1 vdd vdd pch w = 1.2u l = 360n m = 5
M3 out vf 2 vdd pch w = 1.2u l = 360n m = 5
M2 out vf 3 vss nch w = 400n l = 360n
M1 3 vf vss vss nch w = 400n l = 360n
.ends

XVCo_amp vdd vss CV_in St_in vf VCo_amp
XSchimmit vdd vss st_in st_out Schimmit
Xinverter vdd vss st_out osc_out inverter
V0 osc_out vf dc = 0v
CL st_in gnd 1p 

.param vd = 1.8

Vdd vdd gnd dc = vd
Vss vss gnd dc = 0v
.ic osc_out = 0v

Vin CV_in gnd dc = 0.6v
*V_osc vf gnd dc = 0.6v




.op
.tran 1ns 1us  sweep Vin 0.2 0.8 0.01
*.meas voscin val = V(Vin)
.meas period trig V(osc_out) val = 0.6v rise = 3
+targ V(osc_out) val = 0.6v rise = 4
.meas posLength trig V(osc_out) val = 0.6v rise = 3
+targ V(osc_out) val = 0.6v fall = 3

*.alter 
*Vin CV_in gnd dc = 0.7v



.end

*Need to ask how to calculate the cap charging time

