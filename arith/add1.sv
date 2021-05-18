`ifndef __add1

`include "../logic/xor.sv"
`include "../logic/and.sv"

`include "../active/hlatch.sv"

`include "../flow/split.sv"

(* keep_hierarchy *)
module a_add1 #(
  parameter Rpol = 1'b0
  ) (
    input r_i,
    output a_i,
    input [1:0] d_i,

    input rc_i,
    output ac_i,
    input dc_i,

    output r_o,
    input a_o,
    output d_o,

    output rc_o,
    input ac_o,
    output dc_o,

    input rst);

  wire da, db;
  assign {da, db} = d_i;

  wire r_sum1, a_sum1, d_sum1;

  a_xor #(.Rpol(Rpol)) sum1 (
    r_i, a_i, da,
    r_i, a_i, db,
    r_sum1, a_sum1, d_sum1,
    rst
    );

  wire r_sum1_l, a_sum1_l, d_sum1_l;

  hlatch #(.Rpol(Rpol)) sum1_latch (
    r_sum1, a_sum1, d_sum1,
    r_sum1_l, a_sum1_l, d_sum1_l,
    rst
    );

  wire r_gen1, a_gen1, d_gen1;

  a_and #(.Rpol(Rpol)) gen1 (
    r_i, a_i, da,
    r_i, a_i, db,
    r_gen1, a_gen1, d_gen1,
    rst
    );

  wire r_gen1_l, a_gen1_l, d_gen1_l;

  hlatch #(.Rpol(Rpol)) gen1_latch (
    r_gen1, a_gen1, d_gen1,
    r_gen1_l, a_gen1_l, d_gen1_l,
    rst
    );

  wire r_gen1_ls, a_gen1_ls, d_gen1_ls;
  wire r_prop1, a_prop1, d_prop1;

  split #(.Rpol(Rpol)) gen1_split (
    r_gen1_l, a_gen1_l,
    r_gen1_ls, a_gen1_ls,
    r_prop1, a_prop1,
    rst
    );
  assign d_gen1_ls = d_gen1_l;
  assign d_prop1 = d_gen1_l;


endmodule

`define __add1
`endif
