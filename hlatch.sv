`ifndef __hlatch

`include "mullerc.sv"
`include "dlatch.sv"

module hlatch #(
    parameter RdataVal = 1'b0, // reset value (data)
    parameter RhandshakeVal = 1'b0, // reset value (handshake)
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter N = 32'b1,

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input r_i,
  output a_i,
  input [N-1:0] d_i,

  output r_o,
  input a_o,
  output [N-1:0] d_o,

  input rst);

  wire waiting;
  assign r_o = waiting;
  assign a_i = waiting;

  mullerc #(
    .Rval(RhandshakeVal),
    .Rpol(Rpol),
    .A_inv(1'b1),
    .NATIVE(NATIVE)
  ) handshake (a_o, r_i, waiting,
    rst);

  dlatch #(
    .Rval(RdataVal),
    .Rpol(Rpol),
    .N(N),
    .NATIVE(NATIVE)
    // ) latch (waiting & r_i, d_i, d_o,
    ) latch (r_i & ~a_o, d_i, d_o,
      rst);

endmodule

`define __hlatch
`endif
