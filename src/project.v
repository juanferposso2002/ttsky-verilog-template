/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Active High Reset Instance
  wire rst ;
  assign rst = ~rst_n ;

  // Top Module Wires
  wire [1:0] blinker;
  wire [2:0] left;
  wire [2:0] right;

  // Input Pin Assignation
  assign blinker = ui_in[1:0];

  // Top Module Instance
  top thunder(.clk(clk), .rst(rst), .blinker(blinker), .left(left), .right(right));

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[2:0] = left;
  assign uo_out[5:3] = right;
  assign uo_out[7:6] = 2'b00;
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:2], uio_in, 1'b0};

endmodule
