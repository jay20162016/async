`ifndef __xor

`include "../delay/delay.sv"
`include "../flow/combine.sv"

(* keep_hierarchy *)
module a_xor #(
  parameter Rpol = 1'b0,

  parameter N = 32'b1
  ) (
    input ra_i,
    output aa_i,
    input [N-1:0] da_i,

    input rb_i,
    output ab_i,
    input [N-1:0] db_i,

    output r_o,
    input a_o,
    output [N-1:0] d_o,

    input rst);

  wire r_i, a_i;

  combine #(
    .Rpol(Rpol)
    ) combine_inputs (
      ra_i, aa_i,
      rb_i, ab_i,
      r_i, a_i,
      rst
      );

  delay #(
    .T(32'd2),
    .Rpol(Rpol)
    ) req_after_data (
    r_i, r_o, rst
    );

  assign a_i = a_o;

  assign d_o = da_i ^ db_i;

endmodule

`define __xor
`endif
