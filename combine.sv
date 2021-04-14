`ifndef __combine

`include "mullerc.sv"

module combine #(
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input r_i,
  output a_i,

  input r1_i,
  output a1_i,

  output r_o,
  input a_o,

  input rst);

  assign a_i = a_o;
  assign a1_i = a_o;

  mullerc #(
    .Rval(1'b0),
    .Rpol(Rpol),
    .NATIVE(NATIVE)
  ) main (r_i, r1_i, r_o,
    rst);//AAAHHH

endmodule

`define __combine
`endif
