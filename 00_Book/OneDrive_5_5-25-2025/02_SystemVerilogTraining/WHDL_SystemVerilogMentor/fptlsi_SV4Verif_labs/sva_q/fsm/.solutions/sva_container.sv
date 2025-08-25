import types_pkg::*;

module sva_container ( 
  input state_values state, 
  input wire[3:0] opcode,
  input clk
  );
                 
property p_nop;
  @(posedge clk)
  state==IDLE && opcode == NOP |=> state == IDLE;
endproperty

property p_wt_wd;
  @(posedge clk)
  state==IDLE && opcode == WT_WD |=>
  state == WT_WD_1 ##1
  state == WT_WD_2 ##1
  state == IDLE;
endproperty

property p_wt_blk;
  @(posedge clk)
  state==IDLE && opcode == WT_BLK |=>
  state == WT_BLK_1 ##1
  state == WT_BLK_2 ##1
  state == WT_BLK_3 ##1
  state == WT_BLK_4 ##1
  state == WT_BLK_5 ##1
  state == IDLE;
endproperty

property p_rd_wd;
  @(posedge clk)
  state==IDLE && opcode == RD_WD |=>
  state == RD_WD_1 ##1
  state == RD_WD_2 ##1
  state == IDLE;
endproperty

assert_p_nop1: assert property(p_nop)
                     else $display ("p_nop error");

assert_p_wt_wd1: assert property(p_wt_wd)
                     else $display ("p_wt_wd error");
                     
assert_p_wt_blk1: assert property(p_wt_blk)
                     else $display ("p_wt_blk error");
                     
assert_p_rd_wd1: assert property(p_rd_wd)
                     else $display ("p_rd_wd error");

endmodule
