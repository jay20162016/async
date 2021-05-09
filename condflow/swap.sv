`ifndef __swap

`include "../flow/split.sv"
`include "../condflow/mux.sv"

module swap #(
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter N = 32'b1,

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input r_i,
  output a_i,
  input [N-1:0] d_i,

  input r1_i,
  output a1_i,
  input [N-1:0] d1_i,

  input ctl_a,
  input ctl_b,
  output actl_i,

  output r_o,
  input a_o,
  output [N-1:0] d_o,

  output r1_o,
  input a1_o,
  output [N-1:0] d1_o,

  input rst);

  wire r1_i_s, a1_i_s, d1_i_s;
  wire r1_i_s1, a1_i_s1, d1_i_s1;

  assign d1_i_s = d_i;
  assign d1_i_s1 = d_i;

  assign r1_i_s = r_i;
  assign r1_i_s1 = r_i;

  assign a_i = a1_i_s | a1_i_s1;

  // split #(.Rpol(Rpol), .NATIVE(NATIVE)) r1_split (
  //   r_i, a_i,
  //   r1_i_s, a1_i_s,
  //   r1_i_s1, a1_i_s1,
  //   rst
  //   );

  wire r2_i_s, a2_i_s, d2_i_s;
  wire r2_i_s1, a2_i_s1, d2_i_s1;

  assign d2_i_s = d1_i;
  assign d2_i_s1 = d1_i;

  assign r2_i_s = r1_i;
  assign r2_i_s1 = r1_i;

  assign a1_i = a2_i_s | a2_i_s1;

  // split #(.Rpol(Rpol), .NATIVE(NATIVE)) r2_split (
  //   r1_i, a1_i,
  //   r2_i_s, a2_i_s,
  //   r2_i_s1, a2_i_s1,
  //   rst
  //   );

  wire actl_i1, actl_i2;

  split #(.Rpol(Rpol), .NATIVE(NATIVE)) ctl_split (
    , actl_i,
    , actl_i1,
    , actl_i2,
    rst
    );

  mux #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) mux1 (
    r1_i_s, a1_i_s, d1_i_s,
    r2_i_s, a2_i_s, d2_i_s,
    ctl_a, ctl_b, actl_i1,
    r_o, a_o, d_o,
    rst
    );

  mux #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) mux2_ (
    r2_i_s1, a2_i_s1, d2_i_s1,
    r1_i_s1, a1_i_s1, d1_i_s1,
    // r2_i_s1, a2_i_s1, d2_i_s1,
    // ctl_b, ctl_a, actl_i2,
    ctl_a, ctl_b, actl_i2,
    r1_o, a1_o, d1_o,
    rst
    );


endmodule

`define __swap
`endif
