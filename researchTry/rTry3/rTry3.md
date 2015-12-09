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
