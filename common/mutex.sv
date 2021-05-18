`ifndef __mutex

`include "mullerc.sv"

(* keep_hierarchy *)
module mutex #(
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input a,
  input b,

  output o_a,
  output o_b,

  input rst);

  wire ot_a, ot_b;

  mullerc #(.B_inv(1'b1), .Rpol(Rpol), .NATIVE(NATIVE)) r0 (
    a, b,
    ot_a,
    rst);
  assign ot_b=~ot_a;

  assign o_a = ot_a & a;
  assign o_b = ot_b & b;

endmodule

`define __mutex
`endif
