`ifndef __delay

`include "delay_one.sv"

module delay #(
    parameter T = 32'b1,

    parameter Rval = 1'b0, // reset value
    parameter Rpol = 1'b0  // reset polarity (rst=rpol => reset)
  ) (
  input i,
  output o,
  input rst);

  wire [T:0] path;

  assign path[0] = i;
  assign o = path[T];

  genvar gen_i;
  generate
    for (gen_i = 0; gen_i < T; gen_i = gen_i + 1) begin
      delay_one #(.Rval(Rval), .Rpol(Rpol)) main (path[gen_i], path[gen_i+1], rst);
    end
  endgenerate

endmodule

`define __delay
`endif
