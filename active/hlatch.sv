`ifndef __hlatch

`include "../common/mullerc.sv"
`include "dlatch.sv"
`include "../delay/delay.sv"

module hlatch #(
    parameter RdataVal = 1'b0, // reset value (data)
    parameter RhandshakeVal = 1'b0, // reset value (handshake)
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter N = 32'b1,
    parameter T = 32'b0,

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
  wire waiting2;
  assign r_o = waiting2;
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

  delay #(
    .T(T),
    .Rval(Rval),
    .Rpol(Rpol)
    ) req_after_data (waiting, waiting2, rst);

endmodule

`define __hlatch
`endif
