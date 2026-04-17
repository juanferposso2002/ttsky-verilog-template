<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This design implements a 4-bit synchronous counter.
The counter increments its value on every rising edge of the clock signal. 
When reset (rst_n) is low, the counter is cleared to 0.
The counter output is mapped to uo_out[3:0].

## How to test

Apply reset (rst_n = 0) to initialize the counter.
Release reset (rst_n = 1).
Toggle ui_in[0] to generate a clock signal.
Observe the output on uo_out[3:0].
The output should increment in binary: 0000 → 0001 → 0010 → ... → 1111 → 0000

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
