`ifndef __mullerc

`include "lut.v"

module mullerc #(
    parameter Rval = 1'b0, // reset value
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter A_inv = 1'b0, // invert A
    parameter B_inv = 1'b0, // invert B

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input a, b,
  output o,
  input rst);

  localparam I_A = A_inv ? ~`IB : `IB;
  localparam I_B = B_inv ? ~`IC : `IC;

  localparam I_RST = Rpol ? `ID : ~`ID;

  localparam LUT_NORST = ((I_A & I_B) | (`IA & (I_A | I_B)));
  localparam LUT = Rval ? LUT_NORST | I_RST : LUT_NORST & ~I_RST;

  lut #(
    .LUT( LUT ),
    .NATIVE(NATIVE)
  ) main (o, a, b, rst,
            o);

endmodule

`define __mullerc
`endif
