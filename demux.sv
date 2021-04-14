`ifndef __demux

`include "mullerc.sv"

module demux #(
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter N = 32'b1,

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input r_i,
  output a_i,
  input [N-1:0] d_i,

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

  assign d_o = d_i;
  assign d1_o = d_i;

  wire acki_i;
  assign acki_i = a_o | a1_o;

  assign actl_i = acki_i;
  assign a_i = acki_i;

  mullerc #(.Rval(1'b0), .Rpol(Rpol), .NATIVE(NATIVE)) r0 (
    ctl_a, r_i,
    r_o,
    rst);

  mullerc #(.Rval(1'b0), .Rpol(Rpol), .NATIVE(NATIVE)) r1 (
    ctl_b, r_i,
    r1_o,
    rst);

endmodule

`define __demux
`endif
