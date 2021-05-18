`ifndef __merge

`include "../common/mutex.sv"

(* keep_hierarchy *)
module merge #(
    parameter N = 32'b1
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

  assign r_o = r_i | r1_i;

  assign a_i = a_o;
  assign a1_i = a_o;

  wire mux_select;

  mutex data_mux (
    r_i, r1_i,
    mux_select,,
    rst
    );

  assign d_o = mux_select ? d_i : d1_i;

endmodule

`define __merge
`endif
