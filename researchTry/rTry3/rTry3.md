### Waveform Analsis
#### Cap Adding

* Nothing append

output = v(inx)                 
    poles ( hertz)      
        real            imag      
        -15.4934k       0.        
        1.38801x        4.14834x  
        1.38801x        -4.14834x
        -5.49381x       -1.77865x
        -5.49381x       1.77865x  
        -17.9000x       0.        
        -50.9553x       0.        
    zeros ( hertz)      
        real            imag      
        -692.278        0.        
        -11.0236k       0.        
        -6.13009x       3.87796x  
        -6.13009x       -3.87796x
        -10.9760x       0.        
        -50.1216x       0.        
<img src="inx_Nothingappend.png" height="250px"></img>

* Cinx = 10p append

output = v(inx)   
    poles ( hertz)      
        real            imag      
        8.38191k        391.055k  
        8.38191k        -391.055k
        -15.4868k       0.        
        -6.11517x       -3.84215x
        -6.11517x       3.84215x  
        -11.0413x       0.        
        -50.1273x       0.                            
    zeros ( hertz)      
        real            imag      
        -692.278        0.        
        -11.0236k       0.        
        -6.13009x       -3.87796x
        -6.13009x       3.87796x  
        -10.9760x       0.        
        -50.1216x       0.        
<img src="inx_10pappend.png" height="250px"></img>

* Cinx = 20p append

output = v(inx)   
    poles ( hertz)      
        real            imag      
        5.12047k        -276.933k
        5.12047k        276.933k
        -15.4801k       0.       
        -6.12259x       -3.85992x
        -6.12259x       3.85992x
        -11.0088x       0.       
        -50.1244x       0.      
    zeros ( hertz)      
        real            imag      
         -692.278        0.       
        -11.0236k       0.       
        -6.13009x       -3.87796x
        -6.13009x       3.87796x
        -10.9760x       0.       
        -50.1216x       0.       



* cout = 300p
+ rg = 1x make op gain = 40db
+ c2 = 900f bandwidth = 1.5k




### Loop Gain with Copy
#### C vgc_op

With CL = 100p

output = v(inxc)                                
    poles ( hertz)     
        real            imag     
        -78.4018        69.6941k
        -78.4018        -69.6941k
        -152.580        0.       
        <!-- -10.6877k       0.        -->
        -94.1758k       29.9901x
        -94.1758k       -29.9901x
        -6.14247x       3.86509x
        -6.14247x       -3.86509x
        -11.2014x       0.       
        -50.1209x       0.       
        -159.155x       0.       
    zeros ( hertz)     
        real            imag     
        <!-- -10.6804k       0.        -->
        277.447k        30.0248x
        277.447k        -30.0248x
        -4.03199x       0.       
        -7.51406x       0.       
        9.23508x        5.75684x
        9.23508x        -5.75684x
        -47.2093x       0.       
        -159.155x       0.       
        401.096x        0.  

* C vgc_vop = 5p

output = v(inxc)                            
    poles ( hertz)     
        real            imag     
        <!-- -152.580        0.        -->
        -649.966        29.7190x
        -649.966        -29.7190x
        6.25363k        -65.5081k
        6.25363k        65.5081k
        <!-- -10.6876k       0.        -->
        -334.634k       0.       
        <!-- -6.94165x       -2.48086x
        -6.94165x       2.48086x
        -48.7976x       0.       
        -159.155x       0.          -->
    zeros ( hertz)     
        real            imag     
        -10.6804k       0.       
        277.447k        30.0248x
        277.447k        -30.0248x
        -4.03199x       0.       
        -7.51406x       0.       
        9.23508x        5.75684x
        9.23508x        -5.75684x
        -47.2093x       0.       
        -159.155x       0.       
        401.095x        0.       

* C vgc_vop = 10p

output = v(inxc)              

    poles ( hertz)     
        real            imag     
        <!-- -152.580        0.        -->
        -598.774        29.7149x
        -598.774        -29.7149x
        9.55164k        -60.7046k
        9.55164k        60.7046k
        <!-- -10.6876k       0.        -->
        -193.775k       0.       
        <!-- -6.95073x       2.49823x
        -6.95073x       -2.49823x
        -48.7833x       0.       
        -159.155x       0.        -->
    zeros ( hertz)     
        real            imag     
        -10.6804k       0.       
        277.447k        -30.0248x
        277.447k        30.0248x
        -4.03199x       0.       
        -7.51406x       0.       
        9.23508x        -5.75684x
        9.23508x        5.75684x
        -47.2093x       0.       
        -159.155x       0.       
        401.094x        0.       

#### Cinx

* C
