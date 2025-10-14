# Edge Acoustic Accelerator — Overview

This project is an **open-source analog accelerator** for **edge acoustic event detection**.
It uses an 8-band filterbank, envelope detectors, a **current-mode MAC**, and a **Winner-Take-All (WTA)** classifier to output a class ID with sub-50 ms latency at µW–mW power.

- **Target nodes:** SKY130 / GF180 (open PDKs)
- **Tools:** Xschem, ngspice, Magic/KLayout, Netgen, Yosys/OpenROAD/OpenLane
- **I/O:** SPI control, `class[1:0]`, `VALID`, `MARGIN_OK`, analog test MUX

## Why this matters
Analog compute near the sensor reduces ADC bandwidth and MCU wakeups. A small WTA tile can act as an always-on “ear” for wake-word or event detection.

## Links
- Open shuttles & community: [Efabless](https://efabless.com/)
- SKY130 docs: [SkyWater PDK](https://skywater-pdk.readthedocs.io/en/latest/)
- OpenROAD/OpenLane: [OpenROAD Project](https://theopenroadproject.org/)

## Getting started
See the main [README](../README.md) for quickstart, tool setup, and firmware notes.

## Roadmap (condensed)
- Fill and verify Xschem cells (`bpf_cell`, `rectifier`, `envelope_lpf`, `weight_slice`, `wta_core`)
- Post-layout extraction & corners
- OpenLane hardening for SPI register bank
- Eval board bring-up + demo video
