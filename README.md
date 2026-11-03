# I2C Master Controller (FPGA Implementation & Verification)

[![Target FPGA](https://img.shields.io/badge/FPGA-Artix--7%20(xc7a35t)-blue)](#)
[![HDL](https://img.shields.io/badge/HDL-Verilog-orange)](#)
[![EDA Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An RTL implementation of a robust I2C Master Controller designed in Verilog HDL and implemented on the Xilinx Artix-7 FPGA (xc7a35t). The design features complete bus arbitration, dynamic clock prescaling, 7-bit addressing, and ACK/NACK verification.

---

## 📌 Architectural Overview

![Project Overview](project_overview.png)

### Key Features
- *Protocol Compliance:* Supports standard START, STOP, and Repeated START framing.
- *Clock Prescaler:* SCL generated dynamically from a 50 MHz input reference clock.
- *Status & Flag Handling:* Built-in indicators for busy transmission status and ack_error detection.
- *Bidirectional Bus Management:* Open-drain sda control with synchronized tri-state logic handling.

---

## 📊 Post-Implementation Utilization (Artix-7 xc7a35t)

| Resource | Used | Available | Utilization (%) |
| :--- | :--- | :--- | :--- |
| *Slice LUTs* | 80 | 20,800 | *0.38%* |
| *Slice Registers (FF)* | 47 | 41,600 | *0.11%* |
| *Bonded IOB* | 31 | 106 | *29.25%* |
| *BUFGCTRL (Global Buffers)* | 1 | 32 | *3.13%* |

Minimal logic footprint allows integration as an on-chip IP block for sensor interfacing.

---

## 🛠️ Verification & Design Phases

1. *Behavioral Simulation:* Validated write/read transactions with 7-bit slave addresses (0x50) and data payloads (0xA5). Confirmed proper timing margins for START setup, hold times, and ACK detection.
2. *RTL Elaboration:* 142 cells, 31 I/O ports, and 283 nets synthesized into gate-level structures.
3. *Floorplanning & Implementation:* Placed and routed on bank X0Y1 / X1Y1 slices without setup or hold timing violations.

---

## 📂 Repository Contents

- rtl/i2c_master.v : Synthesizable Verilog RTL source code.
- rtl/tb_i2c_master.v : Self-checking testbench for transaction verification.
-
