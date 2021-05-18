`ifndef __swap_sink

`include "swap.sv"
`include "../active/sink.sv"

(* keep_hierarchy *)
module swap_sink #(
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

  input ctl_a,
  input ctl_b,
  output actl_i,

  output r_o,
  input a_o,
  output [N-1:0] d_o,

  input rst);

  wire rt_o, at_o, dt_o;

  swap #(.Rpol(Rpol), .N(N), .NATIVE(NATIVE)) main (
    r_i, a_i, d_i,
    r1_i, a1_i, d1_i,
    ctl_a, ctl_b, actl_i,
    r_o, a_o, d_o,
    rt_o, at_o, dt_o,
    rst
    );

  sink main_sink (
    rt_o, at_o
    );

endmodule

`define __swap_sink
`endif
