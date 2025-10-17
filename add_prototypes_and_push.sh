#!/data/data/com.termux/files/usr/bin/bash
# === Add analog prototype circuits and SEO metadata ===
set -e

echo "📦 Updating Edge Acoustic Accelerator repo with analog prototypes..."

# Ensure prototypes folder exists
mkdir -p prototypes/spice

# --- README ---
cat > prototypes/README.md <<'EOT'
# Analog Prototype Circuits — Edge Acoustic Accelerator

This section includes early ngspice-level analog prototypes for core AI accelerator functions.

### Included Circuits
- **Winner-Take-All (WTA):** Current-mode competition block (4-input)
- **Switched-Capacitor MAC:** Binary-weighted 4-bit analog multiply-accumulate

These open-source circuits can be simulated with `ngspice` using SKY130 or GF180 PDKs.
They form the foundation for in-memory and analog compute experimentation.

**Keywords:** Gerald Henry, Ger Henry, analog IC design, edge AI, ngspice, open source EDA, WTA, MAC, SKY130, GF180, analog accelerator
EOT

# --- WTA ---
cat > prototypes/spice/wta_4in_ngspice.sp <<'EOT'
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
EOT

# --- MAC ---
cat > prototypes/spice/mac_sc_4bit_ngspice.sp <<'EOT'
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
EOT

# --- SEO HTML Landing ---
cat > prototypes/index.html <<'EOT'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="description" content="Analog prototype circuits for Edge Acoustic Accelerator including WTA and SC-MAC open source ngspice decks.">
<meta name="keywords" content="Gerald Henry, Ger Henry, analog IC design, WTA, MAC, open source EDA, ngspice, SKY130, GF180, edge AI, in-memory computing">
<meta name="author" content="Gerald Henry">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edge Acoustic Accelerator - Analog Prototypes</title>
</head>
<body style="font-family:sans-serif;background:#0a0a0a;color:#eee;margin:40px;">
<h1>Edge Acoustic Accelerator Analog Prototypes</h1>
<p>Open-source analog circuits by Gerald Henry for early analog compute exploration:</p>
<ul>
<li><b>Winner-Take-All (WTA):</b> 4-input competition circuit.</li>
<li><b>Switched-Capacitor MAC:</b> binary-weighted accumulator.</li>
</ul>
<p>Compatible with open PDKs (SkyWater SKY130, GF180). Run using <code>ngspice</code>.</p>
</body>
</html>
EOT

# --- Git commit and push ---
git add prototypes
git commit -m "Add analog prototypes (WTA, MAC) + SEO landing page for better indexing"
git push

echo "✅ Done: Analog prototype data added and pushed successfully."
