*hw1
.protect
.lib 'cic018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 
***netlist***
.subckt Schimmit vdd vss In Out 
Ms1p s1pd In vdd vdd p_18 w = 600n l = 360n
Ms2p Out In s1pd s1pd p_18 w = 600n l = 360n
Ms1n Out In s1ns s1ns n_18 w = 400n l = 360n
Ms2n s1ns In vss vss n_18 w = 400n l =360n

Ms3p vss Out s1pd s1pd p_18 w = 400n l = 360n
Ms3n vdd Out s1ns s1ns n_18 w = 400n l = 360n
.ends

XSchimmit vdd vss In Out Schimmit
Vd vdd 0 dc = 1.2v
VS vss 0 dc = 0v
*Vin In 0 dc = 0.6v pulse(0 1.2v 1ns 1ns 1ns 99ns 200ns)
Vin In 0 dc=0.7sv pulse(0 1.2v 1ns 50ns 50ns 0ns 100ns)

.op
.dc sweep Vin 1.2 0 0.01
.tran 1ns 600ns
*.MEAS  drop TRIG V(Out) val=1.18 fall=2 TARG V(In) 
.meas tran drop WHEN V(Out) = 1.18v fall = 1
.meas tran drop_val Find V(In) AT = drop
.meas tran rise WHEN V(Out) = 0.02 rise = 1
.meas tran rise_val Find V(In) AT = rise
.meas tran hysteresis param = 'drop_val - rise_val'
.end