/*
Test fixture for functional level state machines

*/

module test_sm;

reg [31:0] into, outof;
reg rst, clk;
wire [31:0] out_wire, dat;
wire [9:0]  addr;
wire rd_, wr_;

/* nop */
task nop;
# 5 into = {4'b0000,28'h0}; // op_word
endtask

/* the wt_wd op */
task wt_wd;
input [31:0] addr,data;
begin
	#5 into = {4'b0010,28'h0}; // op_word
	@ (posedge clk)
	#5 into = addr; 
	@ (posedge clk)
	#5 into = data; 
end
endtask


/* the wt_blk op */
task wt_blk;
input [31:0] addr,data;
begin
	#5 into = {4'b0011,28'h0}; // op_word
	@ (posedge clk)
	#5 into = addr; // send address
	repeat (4)
	 begin
		@ (posedge clk)
		#5 into = data; // send data 
		data = data +1; // change the data word
	 end
end
endtask

/* the rd_wd op */
task rd_wd;
input [31:0] addr;
begin
	#5 into = {4'b0100,28'h0}; // op_word
	@ (posedge clk)
	#5 into = addr; 
	@ (posedge clk)
	#5 into = 0;  // nop
end
endtask


initial
	into = 0;  // set to nop to start off

/* the clock */
initial
 begin
	clk = 0;
	rst = 1;
	forever
		#10 clk = !clk;
 end

always @(posedge clk)
	outof = #5 out_wire; // put output in register
always @ (outof)  // any change of outof
	$display ($time,,"outof = %h",outof);

integer i;



/* tests */
initial
	begin   
                rst = 0;
		#5 rst = 1;
                #20 rst = 0;
//		repeat(10000) begin
	   	  repeat(3) @ (posedge clk); // wait for 3 clocks
		  @ (posedge clk) wt_wd('h100,'haa);
		  @ (posedge clk) wt_wd('h30,'hbb);
		  @ (posedge clk) wt_blk('h40,'ha10);
		  @ (posedge clk) rd_wd('h100);
		  @ (posedge clk) rd_wd('h30);
		  @ (posedge clk) rd_wd('h40);
		  @ (posedge clk) rd_wd('h41);
		  @ (posedge clk) rd_wd('h42);
		  @ (posedge clk) rd_wd('h43);
		  @ (posedge clk) nop;
//		end
		#100 $stop;
	end
sm_seq  sm_seq0( into, out_wire, rst, clk, dat, addr, rd_, wr_);

beh_sram   sram_0(clk, dat, addr, rd_, wr_);

bind sm sva_container sva_1 (.*);

endmodule

