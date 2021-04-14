`ifndef __arbiter

`include "mutex.sv"
`include "merge.sv"

module arbiter #(
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

  input rst);

  wire rt_i, r1t_i;
  wire rtt_i, r1tt_i;

  mutex #(.Rpol(Rpol), .NATIVE(NATIVE)) mutex_front (
    r_i, r1_i,
    rt_i, r1t_i,
    rst);

  assign rtt_i = rt_i & ~a1_i;
  assign r1tt_i = r1t_i & ~a_i;

  merge2 #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) merge_back (
    rtt_i, a_i, d_i,
    r1tt_i, a1_i, d1_i,
    r_o, a_o, d_o,
    rst);

endmodule

`define __arbiter
`endif
