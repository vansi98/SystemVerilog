/*******************************
*  Sample solution: RTL
*  separate signals, one-hot encoding
*  behavioral memory embedded (no-synthesis)
*/

module sm_func (
        into,
        outof,
 	rst,
        clk);

input [31:0] into;
output [31:0] outof;
input rst, clk;

parameter [9:0]			
  IDLE     = 10'b0000000001,
  WT_WD_1  = 10'b0000000010,
  WT_WD_2  = 10'b0000000100,
  WT_BLK_1 = 10'b0000001000,
  WT_BLK_2 = 10'b0000010000,
  WT_BLK_3 = 10'b0000100000,
  WT_BLK_4 = 10'b0001000000,
  WT_BLK_5 = 10'b0010000000,
  RD_WD_1  = 10'b0100000000,
  RD_WD_2  = 10'b1000000000;

reg [9:0] state, n_state;	

reg [31:0] in_reg, outof,
	addr, w_data, r_data;
reg [7:0] ctrl_reg;
reg [31:0] mem [0:1023]; // memory

reg w_piped_;

wire #1 c_wen_ = !( state[0]);

wire #1 a_wen_ = !( state[1] || state[3] || state[8]);

wire #1 wd_wen_ = !( state[2] || state[4] || state[5] || state[6] || state[7]);

wire #1 rd_wen_ = !( state[9]);

wire #1 inca = ( state[5] || state[6] || state[7]);


always @ (posedge clk)
  begin
    state <= #1 n_state;
  end

always @ (state or rst or in_reg)
  if (rst)
     n_state = IDLE;
  else
     case (state)
	IDLE: // initial state
    	    begin
	      case (in_reg[31:28])
	 	0: // nop
			; // do nothing 
	 	1: // ctrl
			; // do nothing 
	 	2: // wt_wd
			n_state = WT_WD_1;
	 	3: // wt_blk
			n_state = WT_BLK_1;
	 	4: // rd_wd
			n_state = RD_WD_1;
	 	default: 
			$display ($time,,"illegal op received");
 	      endcase
    	    end
  	WT_WD_1: // write word sequence
	    n_state = WT_WD_2;
  	WT_WD_2:
	    n_state = IDLE;
  	WT_BLK_1:
	    n_state = WT_BLK_2;
  	WT_BLK_2:
	    n_state = WT_BLK_3;
  	WT_BLK_3:
  	    begin
              n_state = WT_BLK_4;
            end
  	WT_BLK_4:
            begin
              n_state = WT_BLK_5;
    	    end
  	WT_BLK_5:
  	    begin
              n_state = IDLE;
    	    end
   	RD_WD_1:
	    n_state = RD_WD_2;
  	RD_WD_2:
	    n_state = IDLE;
    endcase

//initial $monitor(mem[64],, $stime,, clk,, addr,, in_reg,, w_piped_,, w_data,, rd_wen_,, r_data);
//initial $monitor(mem[64]);

always @ (posedge clk)
   begin
     in_reg <= #1 into;   // get the input
     outof  <= #1 r_data; // send the output
   end

always 	@ (posedge clk)
		if (!a_wen_)
		 addr <= #1 in_reg;
		else if (inca)
		 addr <= #1 addr + 1;

always 	@ (posedge clk)
		if (!wd_wen_) 
		    w_data <= #1 in_reg;

always 	@ (posedge clk)
	    w_piped_ <= #1 wd_wen_;


always 	@ (posedge clk) 
		if (!w_piped_)
		 mem[addr] <= #1  w_data;	// Perfect Beh. Memory!

always 	@ (posedge clk)
		if (!rd_wen_)
		 r_data <= #1  mem[addr];	// Perfect Beh. Memory!

always 	@ (posedge clk)
		if (!c_wen_)
		 ctrl_reg <= #1 in_reg[7:0];


endmodule
