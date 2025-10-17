* 4-bit switched-capacitor MAC accumulating on Cint
.param VDD=1.8 CUNIT=50f CINT=1p VIN=0.5
VDD vdd 0 {VDD}
Vin xin 0 DC {VIN}
Vphi1 phi1 0 PULSE(0 {VDD} 0n 1n 1n 20n 40n)
Vphi2 phi2 0 PULSE(0 {VDD} 20n 1n 1n 20n 40n)
.model sw_n sw vt=0.45 ron=200 roff=1e9

C1 nC1 0 {CUNIT}
C2 nC2 0 {2*CUNIT}
C3 nC3 0 {4*CUNIT}
C4 nC4 0 {8*CUNIT}

S1a nC1 xin phi1 0 sw_n
S2a nC2 xin phi1 0 sw_n
S3a nC3 xin 0 0 sw_n
S4a nC4 xin phi1 0 sw_n

S1b nC1 nint phi2 0 sw_n
S2b nC2 nint phi2 0 sw_n
S3b nC3 nint phi2 0 sw_n
S4b nC4 nint phi2 0 sw_n

Cint nint 0 {CINT}
Mbuf out nint 0 0 nmos w=8u l=0.5u
Rload out 0 1Meg
.tran 0.1n 2u
.probe v(out) v(nint)
.end
