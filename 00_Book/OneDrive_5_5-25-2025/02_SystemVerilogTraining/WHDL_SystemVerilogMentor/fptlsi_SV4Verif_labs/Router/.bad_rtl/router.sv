module router ( input bit[7:0]  valid, stream,
                input bit clk, rst,
	       output bit[7:0]  busy, valido, streamo);

bit[7:0] out_chan_busy;

frame #(.bit_num(0) )frame0 ( .*); 
/*frame #(.bit_num(1) )frame1 ( .*); 
frame #(.bit_num(2) )frame2 ( .*); 
frame #(.bit_num(3) )frame3 ( .*); 
frame #(.bit_num(4) )frame4 ( .*); 
frame #(.bit_num(5) )frame5 ( .*); 
frame #(.bit_num(6) )frame6 ( .*);
frame #(.bit_num(7) )frame7 ( .*); 
*/
endmodule

module frame  ( input logic  clk, rst );
parameter bit_num = 99;

bit [3:0] a_sr, dest;
bit exit_idle, exit_check_dest, exit_payld;	       
enum {idle, addri, check_dest, delim, val, payld} state, next_state;	       
integer streamo_cnt;
	       
always_ff @(posedge clk or posedge rst)
  if (rst)
    begin
      state = idle;
      router.busy[bit_num] = 0;
      dest = 0;
    end  
  else  	       
    state = next_state;
  
	       
always_comb
  begin
    case(state)
      idle: if (exit_idle) next_state = addri;
      addri: if (a_sr[3]) next_state = check_dest;
      check_dest: if (exit_check_dest) next_state = delim; //addro;
      delim: next_state = val;
      val:   next_state = payld;
      payld: if (exit_payld) next_state = idle;
      default: next_state = idle;
    endcase
  end	       
	       
	       
always_ff @(posedge clk)
  case(state)
      idle: begin 
              a_sr = 4'b0001;
	      dest = 0; 
	      exit_idle = 0;
	      exit_check_dest = 0;
	      exit_payld = 0;
	      streamo_cnt = 0; 
	      if (router.valid[bit_num] && router.stream[bit_num]) exit_idle = 1;
	    end	       
      addri: 
            begin
	      a_sr = {a_sr, router.stream[bit_num]}; 
	      if (a_sr[3])
	        begin
		  router.busy[bit_num] = 1;
		  dest = a_sr[2:0];
		end  
	    end  
      check_dest:
            if (!router.out_chan_busy[dest])
	      begin
  	        router.out_chan_busy[dest] = 1;
		exit_check_dest = 1;
	      end	
      delim:
	    begin
              router.busy[bit_num] = 0;
	    end
      val:
	    begin
              router.valido[dest] = 0;
	    end
      payld: begin
              router.valido[dest] = 1;
              router.streamo[dest] = router.stream[bit_num];
	      streamo_cnt++;
	      if (!router.valid[bit_num]) 
	        begin 
		  exit_payld = 1;
		  router.busy[bit_num] = 1;
		  router.valido[dest] = 0;
		  router.streamo[dest] = 0;
  	          router.out_chan_busy[dest] = 0;
		end
	    end
	      
  endcase	       
	       	       
endmodule	       
