`ifndef __sr_latch

`include "lut.sv"

module sr_latch #(
    parameter Rval = 1'b0, // reset value
    parameter Rpol = 1'b0, // reset polarity (rst=rpol => reset)

    parameter set_inv = 1'b0, // invert A
    parameter reset_inv = 1'b0, // invert B

    parameter NATIVE = 1'b1 // don't optimize
  ) (
  input set, reset,
  output o, o_n,
  input rst);

  localparam I_set = set_inv ? ~`IB : `IB;
  localparam I_reset = reset_inv ? ~`IC : `IC;

  localparam I_RST = Rpol ? `ID : ~`ID;

  localparam LUT_NORST = (`IA | I_set) & ~I_reset;
  localparam LUT = Rval ? LUT_NORST | I_RST : LUT_NORST & ~I_RST;

  lut #(
    .LUT( LUT ),
    .NATIVE(NATIVE)
  ) main (o, set, reset, rst,
            o);
  assign o_n=~o;

endmodule

`define __sr_latch
`endif
