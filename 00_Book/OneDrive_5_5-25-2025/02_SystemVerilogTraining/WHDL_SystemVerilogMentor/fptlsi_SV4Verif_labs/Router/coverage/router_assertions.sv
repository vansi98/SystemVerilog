module router_assertions(input  clk, input logic[7:0] valid, stream);
import defs::*;

sequence s_pass_thru_0 ;
  @(posedge clk) $rose(valid[0]) ##1 !stream[0] ##1 !stream[0] ##1 !stream[0];
endsequence
sequence s_pass_thru_1 ;
  @(posedge clk) $rose(valid[1]) ##1 !stream[1] ##1 !stream[1] ##1  stream[1];
endsequence
sequence s_pass_thru_2 ;
  @(posedge clk) $rose(valid[2]) ##1 !stream[2] ##1  stream[2] ##1 !stream[2];
endsequence
sequence s_pass_thru_3 ;
  @(posedge clk) $rose(valid[3]) ##1 !stream[3] ##1  stream[3] ##1  stream[3];
endsequence
sequence s_pass_thru_4 ;
  @(posedge clk) $rose(valid[4]) ##1  stream[4] ##1 !stream[4] ##1 !stream[4];
endsequence
sequence s_pass_thru_5 ;
  @(posedge clk) $rose(valid[5]) ##1  stream[5] ##1 !stream[5] ##1  stream[5];
endsequence
sequence s_pass_thru_6 ;
  @(posedge clk) $rose(valid[6]) ##1  stream[6] ##1  stream[6] ##1 !stream[6];
endsequence
sequence s_pass_thru_7 ;
  @(posedge clk) $rose(valid[7]) ##1  stream[7] ##1  stream[7] ##1  stream[7];
endsequence



always @( s_pass_thru_0) begin if (`TRACE_ON) $display("Passthru 0 ");  passthru[ 0] = 1; end
always @( s_pass_thru_1) begin if (`TRACE_ON) $display("Passthru 1 ");  passthru[ 1] = 1; end
always @( s_pass_thru_2) begin if (`TRACE_ON) $display("Passthru 2 ");  passthru[ 2] = 1; end
always @( s_pass_thru_3) begin if (`TRACE_ON) $display("Passthru 3 ");  passthru[ 3] = 1; end
always @( s_pass_thru_4) begin if (`TRACE_ON) $display("Passthru 4 ");  passthru[ 4] = 1; end
always @( s_pass_thru_5) begin if (`TRACE_ON) $display("Passthru 5 ");  passthru[ 5] = 1; end
always @( s_pass_thru_6) begin if (`TRACE_ON) $display("Passthru 6 ");  passthru[ 6] = 1; end
always @( s_pass_thru_7) begin if (`TRACE_ON) $display("Passthru 7 ");  passthru[ 7] = 1; end

endmodule
