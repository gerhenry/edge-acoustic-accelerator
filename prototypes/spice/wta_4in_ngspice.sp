* 4-input current-mode Winner-Take-All
.param VDD=1.8
.model nfet nmos level=1 kp=200e-6 vt0=0.45
.model pfet pmos level=1 kp=80e-6 vt0=-0.5

VDD vdd 0 {VDD}
I1 n1 0 DC 5u
I2 n2 0 DC 8u
I3 n3 0 DC 12u
I4 n4 0 DC 3u

Rload1 n1out 0 100k
Rload2 n2out 0 100k
Rload3 n3out 0 100k
Rload4 n4out 0 100k

Mn1 n1 ninh 0 0 nfet w=4u l=0.35u
Mp1 vdd n1 n1 vdd pfet w=2u l=0.5u
Msel1 n1out n1 0 0 nfet w=4u l=0.35u

Mn2 n2 ninh 0 0 nfet w=4u l=0.35u
Mp2 vdd n2 n2 vdd pfet w=2u l=0.5u
Msel2 n2out n2 0 0 nfet w=4u l=0.35u

Mn3 n3 ninh 0 0 nfet w=4u l=0.35u
Mp3 vdd n3 n3 vdd pfet w=2u l=0.5u
Msel3 n3out n3 0 0 nfet w=4u l=0.35u

Mn4 n4 ninh 0 0 nfet w=4u l=0.35u
Mp4 vdd n4 n4 vdd pfet w=2u l=0.5u
Msel4 n4out n4 0 0 nfet w=4u l=0.35u

VBIAS vbias 0 DC 0.6
Mn_inh ninh vbias 0 0 nfet w=8u l=0.35u

.tran 0.1u 10u
.print tran v(n1out) v(n2out) v(n3out) v(n4out) v(ninh)
.end
