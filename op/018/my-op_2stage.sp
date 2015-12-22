***MyOp_2stage

.protect
.lib 'rf018.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1
*.option dccap=1 accurate=1 post

***netlist***
***stack stage***
*Mb	b	cmfb	vdd	vdd	pch	W = 10u   L = 1u   m = 2
*M1	1	Vinp	b		b		pch	W = 28.6u L = 0.4u m = 2
*M2	2	Vinn	b		b		pch	W = 28.6u L = 0.4u m = 2
*M3	3	b3		1		1		pch	W = 7.9u  L = 0.4u m = 2
*M4	4	b3		2		2		pch W = 7.9u  L = 0.4u m = 2
*M5	3	b2		7		7		nch	W = 27u   L = 0.4u m = 3
*M6	4	b2		8		8		nch	W = 27u   L = 0.4u m = 3
*M7	7	b1		vss	vss	nch	W = 14.2u L = 0.4u m = 1
*M8	8	b1		vss	vss	nch	W = 14.2u L = 0.4u m = 1
*

***1nd stage***
Mb	b	cmfb	vdd	vdd	pch	W = 10u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 30u L = 0.4u m = 2
M2	2	Vinp	b		b		pch	W = 30u L = 0.4u m = 2
M5	1	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
M6	2	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
**low f gain = 34.5db 
* for subthreshold diffpair. gain do little with Id. it is more related to Leff and Vds of output mos(about output resistance)
* gds is proportional to 1/leff & vds 
*kappa ~= 0.7     

***2nd stage***
.param cmin = 0.602
m3	von	1		vdd	vdd	pch	w = 18u    l = 1u m = 1
m4	vop	2		vdd	vdd	pch w = 17.83u l = 1u m = 1
m7	von	von	vss	vss	nch	w = 3.8u   l = 1u m = 1	
m8	vop	von	vss	vss	nch	w = 3.7u   l = 1u m = 1

***C load***
*Ct b gnd 10f

***compensation***
C1	1	von	1000f
C2	2	vop	1000f

***param***
.param 
+comon		= 0.5
+bias			= 0.6
+supplyp	= 1.0
+supplyn	= 0
+diff			= 0

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
*vocm	vocm	gnd dc comon 
vb 		cmfb	gnd dc bias *ac = 1 
vb1		b1		gnd dc = 0.3
*vb2		b2		gnd dc = 0.5
*vb3		b3		gnd dc = 0.3

***input***
vinp vinp gnd dc = 'comon+diff' ac = 1
vinn vinn gnd dc = 'comon-diff' ac = 1 -180
*vac  vop	gnd	ac = 1
***input_2ndstage***
*v1 1 gnd dc = 602.3165m ac = 1
*v2 2 gnd dc = 602.3165m ac = 1 180
***output***
*Vo	2	gnd dc = 0.5v

***testing
*mt	vdt	vgt	vdd	vdd	pch	w = 14.2u l = 1u m = 2 		
.param wt = 10u
*mt	vdt	vgt	vdd	vdd	pch	w = wt l = 0.4u m = 2  
mt1	vdt	vgt	vdd	vdd	pch	w = 17.8u l = 1u m = 1    *510n
mt	vdt	vgt	vss	vss	nch	w = 3.9u l = 1u	m = 1	
*mt	vdt	vgt	vss	vss	nch	w = 21.3u l = 0.2u m = 2			
vtg	vgt	gnd dc = 0.3982605v
vtd	vdt	gnd dc = 0.5v

.op

***sweep***
.dc diff -0.5 0.5 0.01
*.dc x -0.5u 0.5u 0.1u sweep y -0.5u 0.5u 0.1u
***testing***
*.dc wt 1u 40u 1000n

***probe&measuring***
.ac dec 1000 10 1g
.tf v(1) vinp
.pz v(vop) vinp
.probe dc I(mt) I(m1) I(m2)
.probe ac I(vac)	cap(von)
+gain1st=par('Vdb(2, 1)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2,1)')
+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')


.end



*    input =  0:vinp          output = v(vop)
* 
*       poles (rad/sec)                 poles ( hertz)
* real            imag            real            imag            
* -167.717k       0.              -26.6930k       0.              
* -682.309k       0.              -108.593k       0.  	 might be 1            
* -18.9886x       0.              -3.02213x       0.     output node         
* -40.0808x       0.              -6.37905x       0.     point b         
* -270.172x       0.              -42.9993x       0.              
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