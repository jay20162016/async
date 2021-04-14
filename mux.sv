`ifndef __mux

`include "merge2.sv"
`include "mullerc.sv"

module mux #(
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

  input rst);

  wire tr_i, tr1_i;

  merge2 #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) merger (
    tr_i, a_i, d_i,
    tr1_i, a1_i, d1_i,
    r_o, a_o, d_o,
    rst,
    actl_i);

  mullerc #(.Rval(1'b0), .Rpol(Rpol), .NATIVE(NATIVE)) r0 (
    ctl_a, r_i,
    tr_i,
    rst);

  mullerc #(.Rval(1'b0), .Rpol(Rpol), .NATIVE(NATIVE)) r1 (
    ctl_b, r1_i,
    tr1_i,
    rst);

endmodule

`define __mux
`endif
