`ifndef __split

`include "../common/mullerc.sv"

(* keep_hierarchy *)
module split #(
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input r_i,
  output a_i,

  output r_o,
  input a_o,

  output r1_o,
  input a1_o,

  input rst);

  assign r_o = r_i;
  assign r1_o = r_i;

  mullerc #(
    .Rval(1'b0),
    .Rpol(Rpol),
    .NATIVE(NATIVE)
  ) main (a_o, a1_o, a_i,
    rst);

endmodule

`define __split
`endif
