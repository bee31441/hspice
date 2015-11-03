### l = 200n
* Nmos vs Pmos size = 1:4(long width)
> ex: vgs = 0.3v, **Wn = 10u**, vd = 0.25 => I = 363n
> vsg = 0.3v, **Wp = 40u**, vds = 0.25 => I = 356n

* Nmos vs Pmos size = 1:2.6(short width)
> ex: vgs = 0.3v, **Wn = 1u**, vd = 0.25 => I = 22.8n
> vsg = 0.3v, **Wp = 2.6u**, vds = 0.25 => I = 22.6n

* ve ~ -2.486 (short channel effect)

* **the info of nch model in rf018 is located in**
    * **Ln.6315 nch.4(L = 180n:500n; W = 10u:900u)**
    * **Ln.6644 nch.8(L = 180n:500n; W = 1.2u:10u)**
    * **Ln.6983 nch.12(L = 180n:500n;; W = 500n:1.2u)**
    * **Ln.7648 pch.4(L = 180n:500n; W = 10u:900u)**
    * **Ln.7983 nch.8(L = 180n:500n; W = 1.2u:10u)**
    * ** Ln.8329 pch.12(L = 180n:500n;; W = 500n:1.2u)**
>To search a data file for MOSFET models within a given range of width and length, provide a root extension for the model reference name (in the .MODEL statement). Also, use the model geometric range parameters LMIN, LMAX, WMIN, and WMAX. These model parameters give the range of the physical length and width dimensions to which the MOSFET model applies. **For example, if the model reference name in the element statement is NCH, the model selection program examines the models with the same root model reference name NCH such as NCH.1, NCH.2 or NCH.A. The model selection program selects the first MOSFET model statement whose geometric range parameters include the width and length specified in the associated MOSFET element statement.**
