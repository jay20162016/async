`ifndef __loop_breaker
(* blackbox, keep *)
module loop_breaker(input A, output Y);
  assign Y = A;
endmodule

`define __loop_breaker
`endif
