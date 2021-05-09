`ifndef __not

`include "../delay/delay.sv"

module a_not #(
  parameter Rpol = 1'b0,

  parameter N = 32'b1
  ) (
    input r_i,
    output a_i,
    input [N-1:0] d_i,

    output r_o,
    input a_o,
    output [N-1:0] d_o,

    input rst);

  delay #(
    .T(32'd2),
    .Rpol(Rpol)
    ) req_after_data (
    r_i, r_o, rst
    );

  assign a_i = a_o;

  assign d_o = ~d_i;

endmodule

`define __not
`endif
