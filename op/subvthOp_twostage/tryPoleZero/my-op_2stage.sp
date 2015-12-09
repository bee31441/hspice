***MyOp_2stage

.protect
.lib 'rf018.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1  unwrap = 1
*.option dccap=1 accurate=1 post

***param***
.param 
+comon		= 0.5
+bias			= 0.6
+bias2		= 0.3
+supplyp	= 1.0
+supplyn	= 0
+diff			= 0
***netlist***
***1st stage***
Mb	b	b0	vdd	vdd	pch	W = 10u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 30u L = 0.4u m = 2
M2	2	Vinp	b		b		pch	W = 30u L = 0.4u m = 2
M5	1	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
M6	2	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
**low f gain = 34.5db 
* for subthreshold diffpair. gain do little with Id. it is more related to Leff and Vds of output mos(about output resistance)
* gds is proportional to 1/leff & vds 
*kappa ~= 0.7     

***2nd stage***
m3	von	1		vdd	vdd	pch	w = 18u    l = 1u   m = 1
m4	vop	2		vdd	vdd	pch w = 3.88u 	 l = 0.2u m = 1
m7	von	von	vss	vss	nch	w = 3.8u   l = 1u   m = 1	
m8	vop	von	vss	vss	nch	w = 1.1u   l = 0.2u m = 1

***Pole Test***
*c0	vop	gnd 200n
*CL	von	gnd 10p
***compensation***
C1	z1		von 400f
Rz1	z1		1   350k	* By cal = 1/gm3. But by sweep result is around 300k~400k
* Because this RHP zero is around the zero db corner. it effect gain under zerodb but effect phase above zerodb.
*	So when this RHP zero become LHP. we can make it very large to gain PM
C2	2			vop 900f  * around 900f has smallest bandwidth
*Rz2	z2	2   10000

*Cl1	1	gnd 400f
*Cl2	2	gnd 400f
*Cb	b		gnd 600f			*use here to cancell right hand zero
*Clp	von	gnd 500f


cout	vop gnd 200n
*rL	vop 	gnd 1x

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias2


***input***
vinp vinp gnd dc = 'comon+diff' ac = 1
vinn vinn gnd dc = 'comon-diff' *ac = 1 -180






***test
*mt	vdt	vgt	vss	vss	nch	w = 2.7u   l = 0.5u m = 1
mt	vdt	vgt	vdd	vdd	pch w = 9.7u l = 0.5u m = 1

vtd	vdt	gnd dc = '1-499.7048m'
vtg	vgt	gnd dc = '1-397.6836m'







.op

***sweep***
.dc diff -0.5 0.5 0.01
***probe&measuring***
.ac dec 100 0.1 10g
.tf v(1) vinp
.pz v(vop) vinp
.probe dc I(m1) I(m2)	I(mt)
.probe ac cap(von)
+gain1st=par('Vdb(2, 1)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2,1)')
+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
.meas ac gain MAX (par('Vdb(vop)-Vdb(vinp,vinn)'))
.meas ac bandwidth WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 'gain-3db'
.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 1
.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 1




.end



*    input =  0:vinp          output = v(vop)
* 
*       poles (rad/sec)                 poles ( hertz)
* real            imag            real            imag            
* -167.717k       0.              -26.6930k       0.              
* -682.309k       0.              -108.593k       0.  	 might be 1            
* -18.9886x       0.              -3.02213x       0.     output node         
* -40.0808x       0.              -6.37905x       0.     point b         
* -270.172x       0.              -42.9993x       0.     might also at 1    
* 
*       zeros (rad/sec)                 zeros ( hertz)
* real            imag            real            imag            
* -707.663k       -118.143        -112.628k       -18.8030   might at 1&2     
* -39.7089x       71.2964         -6.31986x       11.3472         
* 205.758x        0.              32.7474x        0.              
* -222.703x       0.              -35.4443x       0.              
* 1.85816g        0.              295.735x        0.         
*
*
***1st stage***
*    input =  0:vinp          output = v(2,1)
* 
*       poles (rad/sec)                 poles ( hertz)
* real            imag            real            imag            
* -1.59030x       0.              -253.104k       0.              
* -1.85209x       0.              -294.769k       0.              
* -26.8240x       0.              -4.26918x       0.              
* 
*       zeros (rad/sec)                 zeros ( hertz)
* real            imag            real            imag            
* -1.84707x       0.              -293.970k       0.              
* -23.8712x       0.              -3.79922x       0.              
* 97.7912x        0.              15.5640x        0.      
*
*
***with compensation***
*    input =  0:vinp          output = v(vop)              
*                                                          
*       poles (rad/sec)                 poles ( hertz)     
* real            imag            real            imag     
* -1.20041k       0.              -191.051        0.       
* -30.0378k       0.              -4.78067k       0.       
* -58.2260x       0.              -9.26696x       0.       
* -69.7431x       0.              -11.1000x       0.       
* -129.633x       0.              -20.6318x       0.       
*                                                          
*       zeros (rad/sec)                 zeros ( hertz)     
* real            imag            real            imag     
* -39.5540k       0.              -6.29522k       0.       
* 10.9056x        0.              1.73568x        0.       
* -55.8813x       0.              -8.89379x       0.       
* -126.705x       0.              -20.1658x       0.       
* 160.148x        0.              25.4883x        0.       