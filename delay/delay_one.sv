`ifndef __delay_one

`include "../common/lut.sv"

module delay_one #(
    parameter Rval = 1'b0, // reset value
    parameter Rpol = 1'b0  // reset polarity (rst=rpol => reset)
  ) (
  input i,
  output o,
  input rst);

  localparam I_RST = Rpol ? `IC : ~`IC;

  localparam LUT_NORST = `ID;
  localparam LUT = Rval ? LUT_NORST | I_RST : LUT_NORST & ~I_RST;

  lut #(
    .LUT( LUT )
  ) main (1'b0, 1'b0, rst, i,
            o);

endmodule

`define __delay_one
`endif
