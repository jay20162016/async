`ifndef __dlatch

`include "lut.v"

module dlatch #(
    parameter Rval = 1'b0, // reset value
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter N = 32'b1,

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input en,
  input [N-1:0] d,
  output [N-1:0] o,
  input rst);

  genvar gen_i;
  generate
    for (gen_i = 0; gen_i < N; gen_i++) begin
      localparam I_RST = Rpol ? `ID : ~`ID;

      localparam LUT_NORST = (`IB & `IC) | (~`IB & `IA);
      localparam LUT = Rval[gen_i] ? LUT_NORST | I_RST : LUT_NORST & ~I_RST;
      lut #(
        .LUT( LUT ),
        .NATIVE(NATIVE)
      ) main (o[gen_i], en, d[gen_i], rst,
                o[gen_i]);
    end
  endgenerate


endmodule

`define __dlatch
`endif
