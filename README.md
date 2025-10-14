# Edge Acoustic Accelerator

**An open-source, tapeout-friendly analog accelerator** for edge acoustic event detection.  
It performs **band-energy feature extraction → analog MAC → Winner-Take-All (WTA)** classification to detect simple events
(e.g., clap, glass clink, speech-like energy, silence) with **µW–mW** power and **<50 ms** latency.

Designed for **SKY130 / GF180** open PDKs using open EDA tools. Includes an evaluation-board plan and MCU firmware for live demos.

---

## ✨ Highlights
- Analog-first compute: current-mode **MAC + WTA** classifier (4 classes)
- Open tool flow: **Xschem**, **ngspice**, **Magic/KLayout**, **Netgen**, **Yosys/OpenROAD/OpenLane** (tiny regbank/FSM)
- Demo-friendly: **SPI** control + GPIO outputs; firmware lights LEDs & logs results
- Clean repo layout with CI, scripts, and docs

---

## Repo Structure
---

## Quickstart

### 1) Clone
```bash
git clone git@github.com:gerhenry/edge-acoustic-accelerator.git
cd edge-acoustic-accelerator
export PDK_ROOT=/path/to/pdks
export PDK=sky130A
cd analog/sim
make run
cd digital/openlane/user_regbank
flow.tcl -design .
d fw
pio run
pio upload
That’s it—the README will be live on GitHub immediately.0

CTRL + D
