`ifndef __lut

`include "loop_breaker.sv"

`define IA 16'b1111_1111_0000_0000
`define IB 16'b1111_0000_1111_0000
`define IC 16'b1100_1100_1100_1100
`define ID 16'b1010_1010_1010_1010

module lut #(
    parameter [15:0] LUT = 16'b0,
    parameter NATIVE = 1'b1
  ) (
  input d, c, b, a,
  output o);


`ifdef SIMULATION
  // from ice40/cells_sim.v
  wire [7:0] s3 = d ?   LUT[15:8] :   LUT[7:0];
  wire [3:0] s2 = c ?   s3[ 7:4]  :   s3[3:0];
  wire [1:0] s1 = b ?   s2[ 3:2]  :   s2[1:0];
  assign o      = a ?   s1[1]     :   s1[0];

`endif


`ifdef SYNTHESIS
  wire to;
  if (NATIVE) begin
    SB_LUT4 #(.LUT_INIT(LUT)) main (.O(to),
              .I0(a), .I1(b), .I2(c), .I3(d));
  end
  else begin
    \$lut #(.WIDTH(4), .LUT(LUT)) main (.A({d, c, b, a}), .Y(to));
  end

  loop_breaker breaker (to, o);
`endif

`ifdef SIMULATION
  // ice40 up5k timing
  specify
        // https://github.com/cliffordwolf/icestorm/blob/be0bca0230d6fe1102e0a360b953fbb0d273a39f/icefuzz/timings_up5k.txt#L92
        (a => o) = (1245, 1285);
        // https://github.com/cliffordwolf/icestorm/blob/be0bca0230d6fe1102e0a360b953fbb0d273a39f/icefuzz/timings_up5k.txt#L95
        (b => o) = (1179, 1232);
        // https://github.com/cliffordwolf/icestorm/blob/be0bca0230d6fe1102e0a360b953fbb0d273a39f/icefuzz/timings_up5k.txt#L98
        (c => o) = (1179, 1205);
        // https://github.com/cliffordwolf/icestorm/blob/be0bca0230d6fe1102e0a360b953fbb0d273a39f/icefuzz/timings_up5k.txt#L100
        (d => o) = (861, 874);
  endspecify
`endif

endmodule

`define __lut
`endif
