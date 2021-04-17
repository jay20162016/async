`ifndef __sink

module sink (
  input r_i,
  output a_o);

  assign a_o = r_i;

endmodule

`define __sink
`endif
