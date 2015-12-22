Analog IC: CMFB loop AC response 
.protect
.lib 'rf018.l' tt
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC=   1.0000E-12
.include "op-w-cmfb.sp" * Include your OP netlist

.param rload=25k cload=10p * Your load
.param supplyp=1.8 * Your positive supply voltage
.param supplyn=0 * Your negative supply voltage
.param comon=0.9 * Your output common mode voltage
.param bias=0.47
Xop 3 4 von vop Vcm vss b2 vocm vinp vinn cmfb vdd op * Modify your subcircuit name

 
rload1 von 0 rload
rload2 vop 0 rload
cload1 von 0 cload
cload2 vop 0 cload

 
vdd vdd 0 dc supplyp
vgnd vss 0 dc supplyn
vocm vocm 0 dc comon 
$Vfbin vfbi 0 dc 912.6093m ac=1 $sin(912.6093m 1u 100 0 0 0)
vb b2 0 dc bias 
vinp vinp 0 dc comon ac 1
vinn vinn 0 dc comon ac 1

.ac dec 10 10 1g
.meas ac gaindb max vdb('vop-von','vinp-vinn')
$.pz V(vop) Vinp
$.tran 10u 0.01
$.four 100 V(vcms)

.end
