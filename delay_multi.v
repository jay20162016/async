`ifndef __delay_multi

`include "delay.v"

module delay_multi #(
    parameter T = 32'b1,
    parameter N = 32'b1,

    parameter Rval = 1'b0, // reset value
    parameter Rpol = 1'b0  // reset polarity (rst=rpol => reset)
  ) (
  input   [N-1:0] i,
  output  [N-1:0] o,
  input rst);

  genvar gen_i;
  generate
    for (gen_i = 0; gen_i < N; gen_i++) begin
      delay #(.Rval(Rval), .Rpol(Rpol), .T(T)) main (i[gen_i], o[gen_i], rst);
    end
  endgenerate

endmodule

`define __delay_multi
`endif
