`ifndef __merge2

`include "merge.sv"
`include "../common/mullerc.sv"

(* keep_hierarchy *)
module merge2 #(
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

  output r_o,
  input a_o,
  output [N-1:0] d_o,

  input rst,

  output other_ack);

  wire ta_i, ta1_i;

  assign other_ack = ta_i;

  merge #(.N(N)) main (
    r_i, ta_i, d_i,
    r1_i, ta1_i, d1_i,
    r_o, a_o, d_o,
    rst
    );

  mullerc #(.Rval(1'b0), .Rpol(Rpol), .NATIVE(NATIVE)) a0 (
    ta_i, r_i,
    a_i,
    rst
    );
  mullerc #(.Rval(1'b0), .Rpol(Rpol), .NATIVE(NATIVE)) a1 (
    ta1_i, r1_i,
    a1_i,
    rst
    );

endmodule

`define __merge2
`endif
