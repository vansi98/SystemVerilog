/////////////////////////////////////////////////
//
//  Testbench for WHDL sv_assertions Labs
//
// Uses an RTL UART made available by Jeung Joon Lee
// from his free-IP website: www.cmosexod.com
//
//


module test_u_xmit;
reg sys_clk, sys_rst_l, xmit;
reg [7:0] data;
reg [3:0] sys_clk_div16;
wire done, uart_out;
wire uart_clk = sys_clk_div16[3];
integer i;

initial
begin
  sys_clk = 0;
  forever #30 sys_clk = !sys_clk;
end

always @(posedge sys_clk)
begin
  sys_clk_div16 = sys_clk_div16 +1;
end

task transmit(input bit[7:0] n);
begin
  wait(done);
  @(posedge uart_clk)
    #1;
  data = n;
  xmit = 1;
//  @(negedge uart_clk) data = 5;
  @(posedge uart_clk)
    #1;
  data = 0;
  xmit = 0;
  wait(done);  
end
endtask

initial
begin
  sys_rst_l = 1;
  sys_clk_div16 = 0;
  xmit = 0;
  data = 0;
  repeat(5)@(posedge uart_clk);
  sys_rst_l = 0;
///*
  force uart_out = 0;
  force done = 1;
  repeat(3)@(negedge sys_clk);
  release uart_out;
  release done;
//*/  
  repeat(2)@(posedge uart_clk);
  sys_rst_l = 1;
  repeat(10)@(posedge uart_clk);
  for(i = 10; i < 21; i = i+1)
    transmit(i);
  repeat(2)@(posedge uart_clk);
  $stop;  
end

//initial #30000 $stop;

//initial begin #10000 force done = 0; #200 release done; end

initial 
  begin
    $monitor($stime,,sys_rst_l,,sys_clk,,uart_clk,,data,,xmit,,done,,uart_out);
    forever #1000 begin $display("");
      $display("      Time s s u  da x d uo");
      $display("           r c c  ta m n");
    end
  end

    
/* u_xmit U1( .sys_clk,
	   .uart_clk,
	   .sys_rst_l,
	   .uart_out,
	   .xmit,
	   .data,
	   .done
	  ); */

u_xmit U1( .*
	  ); 
	  

bind U1 my_assertions A1 (.*);


endmodule

module my_assertions( input sys_clk, uart_clk, sys_rst_l,
	   	      input uart_out, xmit, done,
	              input [7:0] data );

//`ifdef SVA



// simple post-reset checkers

//XXXXXXXXXXXXXXXXXXXX   LAB  XXXXXXXXXXXXXXXXXXXX	  
//XXXXXXXXXXXXXXXXXXXX STARTS XXXXXXXXXXXXXXXXXXXX	  
//XXXXXXXXXXXXXXXXXXXX  HERE  XXXXXXXXXXXXXXXXXXXX	  
	  
sequence s_uart_sys16; 
  uart_clk[*8] ##1 !uart_clk[*8] ##1 uart_clk;
endsequence

sequence s_xmit_hi16;
  @(posedge sys_clk) xmit[*16]##1 !xmit;
endsequence	  

sequence s_xmit_done;
  ##1 !done && !uart_out;
endsequence	  


//XXXXXXXXXXXXXXXXXXXX END OF LAB  XXXXXXXXXXXXXXXXXXXX	  
//XXXXXXXXXXXXXXXXXXXX END OF LAB  XXXXXXXXXXXXXXXXXXXX	  
//XXXXXXXXXXXXXXXXXXXX END OF LAB  XXXXXXXXXXXXXXXXXXXX	  



sequence s_rst_sigs;
   ##1 (uart_out && !done);
endsequence

sequence s_rst_done;
//  (!sys_rst_l) [*1:$] ##1 sys_rst_l ##1 (done && !xmit) [*1:$] ##1 xmit ;
  (sys_rst_l)[->1] ##1 !xmit ##0 (done throughout ((xmit)[->1]));
endsequence

sequence s_rst_pair;
  s_rst_done and s_rst_sigs;
endsequence


property p_rst_sigs;
  @(posedge sys_clk) ($fell(sys_rst_l)) |-> s_rst_sigs; 
endproperty
	  
property p_rst_done;
  @(posedge sys_clk) ($fell(sys_rst_l)) |-> s_rst_done;
endproperty	  

property p_post_rst;
  @(posedge sys_clk) ($fell(sys_rst_l)) |-> s_rst_pair;
endproperty

//####################
// sys_clk checkers
//####################
//
// sys_clk divider checker

property p_uart_sys16; 
  @(posedge sys_clk) $rose(uart_clk) && !sys_rst_l  |-> s_uart_sys16;
endproperty

//
// xmit and data checks

property p_xmit_hi16;
  @(posedge sys_clk) $rose(xmit) |-> s_xmit_hi16;
endproperty	  

property p_xmit_done;
  @(posedge sys_clk) $rose(xmit) |-> s_xmit_done;
endproperty	  

/*
property p_val_bit_stream;
  bit[7:0] x_byte;
  @(posedge sys_clk) ($fell(done) && xmit, x_byte = data  ) |->
  ##8 (uart_out == 0) ##16
      (uart_out == x_byte[0]) ##16
      (uart_out == x_byte[1]) ##16
      (uart_out == x_byte[2]) ##16
      (uart_out == x_byte[3]) ##16
      (uart_out == x_byte[4]) ##16
      (uart_out == x_byte[5]) ##16
      (uart_out == x_byte[6]) ##16
      (uart_out == x_byte[7]) ##16
      (uart_out == 1) ##16 (uart_out == 1) ##16 (done == 1); 
endproperty	  
*/

//
// Serial protocol checkers

sequence s_xmit_nc_data;
   $stable(data) throughout xmit[*15];
endsequence

property p_xmit_nc_data;
  @(posedge sys_clk) ($rose(xmit)) |=> s_xmit_nc_data;
endproperty

/* 
property p_xmit_nc_data;
  bit[7:0] x_byte;
  @(posedge sys_clk) ($rose(xmit), x_byte = data) |=> (data == x_byte) throughout xmit[*15];
endproperty
*/

property p_done_175;
  @(posedge sys_clk) $rose(xmit) |=> !done[*175] ##1 done;
endproperty

// assertions

assert_uart_sys16: assert property (p_uart_sys16) //$display("%m :OK!");
                       else $display("%m : uart_clk should = sys_clk/16");

assert_rst_sigs: assert property (p_rst_sigs) //$display("%m :OK!");
                       else $display("%m : Signals uart_out and done failed to reset");

assert_rst_done: assert property (p_rst_done) //$display("%m :OK!");
                       else $display("%m : Problems with done after reset");

assert_post_rst: assert property (p_post_rst) //$display("%m :OK!");
                       else $display("%m : device did not reset");

assert_xmit_hi16: assert property (p_xmit_hi16) //$display("%m :OK!");
                       else $display("%m : Signal xmit should stay hi for 16 sys_clks");

assert_xmit_done: assert property (p_xmit_done) //$display("%m :OK!");
                       else $display("%m : Posedge xmit should take done and uart_out low.");

assert_xmit_nc_data: assert property (p_xmit_nc_data) //$display("%m :OK!");
                       else $display("%m : data should not change while xmit asserted");

assert_done_175: assert property (p_done_175) //$display("%m :OK!");
                       else $display("%m : Byte transmission (done low) should take 175 sys_clk");




//assert_val_bit_stream: assert property (p_val_bit_stream) //$display("%m :OK!");
//                       else $display("%m : uart_out bitstream incorrect");

//cover_val_bit_stream: cover property (p_val_bit_stream);

//####################
// uart_clk checkers
//####################
//
// 

reg[7:0] y_byte;
always @(negedge uart_clk)
  if (xmit) y_byte = data;

sequence s_val_bit_stream_uart_clk;
  bit[7:0] x_byte;
   @(negedge uart_clk)
      (uart_out == 0) ##1
      (uart_out == y_byte[0]) ##1
      (uart_out == y_byte[1]) ##1
      (uart_out == y_byte[2]) ##1
      (uart_out == y_byte[3]) ##1
      (uart_out == y_byte[4]) ##1
      (uart_out == y_byte[5]) ##1
      (uart_out == y_byte[6]) ##1
      (uart_out == y_byte[7]) ##1
      (uart_out == 1);
//      ##1 (uart_out == 1) ##1
//      (done == 1);
endsequence


property p_xmit_hi1;
  @(posedge uart_clk) $rose(xmit) |-> ##1 $fell(xmit);
endproperty	  

property p_done_11;
  @(posedge uart_clk) ($fell(done) && xmit ) |=> /* s_xmit_hi16.matched */ ##10 $rose(done);
endproperty

property p_val_bit_stream_uart_clk;
  @(negedge uart_clk) ($fell(done) && xmit ) |-> s_val_bit_stream_uart_clk; //(data);
endproperty	  



assert_xmit_hi1: assert property (p_xmit_hi1) //$display("%m :OK!");
                       else $display("%m : Signal xmit should stay hi for 1 uart_clk");

assert_done_11: assert property (p_done_11) //$display("%m :OK!");
                       else $display("%m : Byte transmission (done low) should take 11 uart_clks");

assert_val_bit_stream_uart_clk: assert property (p_val_bit_stream_uart_clk) //$display("%m :OK!");
                       else $display("%m : uart_out bitstream incorrect");


//********** lab multiclock


//Your Code here






//`endif 		       
		       	  
endmodule

