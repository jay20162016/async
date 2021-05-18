`ifndef __demux2

`include "demux.sv"

(* keep_hierarchy *)
module demux2 #(
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter N = 32'b1,

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input r_i,
  output a_i,
  input [N-1:0] d_i,

  input rctl_i,
  input dctl_i,
  output actl_i,

  output r_o,
  input a_o,
  output [N-1:0] d_o,

  output r1_o,
  input a1_o,
  output [N-1:0] d1_o,

  input rst);

  demux #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) main (
    r_i, a_i, d_i,
    rctl_i & ~dctl_i, rctl_i & dctl_i, actl_i,
    r_o, a_o, d_o,
    r1_o, a1_o, d1_o,
    rst
    );

endmodule

`define __demux2
`endif
