`ifndef __swap_sink2

`include "swap2.sv"
`include "../active/sink.sv"

(* keep_hierarchy *)
module swap_sink2 #(
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

  input rctl_i,
  input dctl_i,
  output actl_i,

  output r_o,
  input a_o,
  output [N-1:0] d_o,

  input rst);

  wire rt_o, at_o, dt_o;

  swap2 #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) main (
    r_i, a_i, d_i,
    r1_i, a1_i, d1_i,
    rctl_i, dctl_i, actl_i,
    r_o, a_o, d_o,
    rt_o, at_o, dt_o,
    rst
    );

  sink main_sink2 (
    rt_o, at_o
    );

endmodule

`define __swap_sink2
`endif
