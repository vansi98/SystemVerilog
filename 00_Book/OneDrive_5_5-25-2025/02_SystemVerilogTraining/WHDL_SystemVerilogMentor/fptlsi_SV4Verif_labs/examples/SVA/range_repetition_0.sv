`define true 1
module range_repetition_0;
bit a = 0;
bit b = 0;
bit c = 0;
bit clk = 0;


always #20 clk = !clk;


initial begin
// range_rep_0_exa & b
  @ (negedge clk)
    a = 1;
  @ (negedge clk)
    a = 0;
    b = 1;
  @ (negedge clk)
    b = 0;
    c = 1;
  @ (negedge clk)
    c = 0;
  
// second equiv for exb
  @ (negedge clk)
    a = 1;
  @ (negedge clk)
    a = 0;
    c = 1;
  @ (negedge clk)
    c = 0;

  @ (negedge clk) $finish;
end


//************ [*0:M]

property p_range_rep_0_exa;
  @(posedge clk) b |-> (a[*0:1] ##1 b ##1 c);
endproperty

property p_range_rep_0_exb;
  @(posedge clk) b |-> (a ##1 b [*0:1] ##1 c);
endproperty

a_range_rep_0_exa:   assert property(p_range_rep_0_exa);
a_range_rep_0_exb:   assert property(p_range_rep_0_exb);


endmodule
