`ifndef __source

module source (
  output r_o,
  input a_i);

  assign r_o = ~a_i;

endmodule

`define __source
`endif
