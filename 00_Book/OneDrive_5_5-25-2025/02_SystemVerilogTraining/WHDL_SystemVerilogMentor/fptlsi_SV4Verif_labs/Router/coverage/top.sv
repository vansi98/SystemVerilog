//  `define TRACE_ON  0
//  `define DEBUG_ON  0

module top;
  import defs::*;

  parameter simulation_cycle = 100 ;
  logic  SystemClock ;
  router_if top_if(SystemClock);
  test_router test(top_if);
  router dut(
    .rst ( top_if.rst ),
    .clk ( top_if.clock ),
    .valid ( top_if.valid ),
    .stream ( top_if.stream ),
    .streamo ( top_if.streamo ),
    .busy ( top_if.busy ),
    .valido ( top_if.valido )
  );
  bind dut router_assertions RA (.*);

  initial begin
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2) 
        SystemClock = ~SystemClock ;
    end
  end

/*
wire v7,v6,v5,v4,v3,v2,v1,v0;
assign {v7,v6,v5,v4,v3,v2,v1,v0} = top_if.valido;
wire s7,s6,s5,s4,s3,s2,s1,s0;
assign {s7,s6,s5,s4,s3,s2,s1,s0} = top_if.streamo;

property check_frame(v,s);
  bit[2:0] dest;
  bit[7:0] data;
  @(posedge SystemClock)
      $rose(v) |->  
		      (    (v, data[7] = s)
		       ##1 (v, data[6] = s)
		       ##1 (v, data[5] = s)
		       ##1 (v, data[4] = s)
		       ##1 (v, data[3] = s)
		       ##1 (v, data[2] = s)
		       ##1 (v, data[1] = s)
		       ##1 (v, data[0] = s  
`ifdef DEBUG_ON
   	       , $display("%m   Received: %0h", data) 
`endif		       
		        ) )[*1:$] ##1 !v;

endproperty			   

ck_frm_7: assert property(check_frame (v7,s7)) 
                             else $display("%m Bad frame received.");
ck_frm_6: assert property(check_frame (v6,s6)) 
                             else $display("%m Bad frame received.");
ck_frm_5: assert property(check_frame (v5,s5)) 
                             else $display("%m Bad frame received.");
ck_frm_4: assert property(check_frame (v4,s4)) 
                             else $display("%m Bad frame received.");
ck_frm_3: assert property(check_frame (v3,s3)) 
                             else $display("%m Bad frame received.");
ck_frm_2: assert property(check_frame (v2,s2)) 
                             else $display("%m Bad frame received.");
ck_frm_1: assert property(check_frame (v1,s1)) 
                             else $display("%m Bad frame received.");
ck_frm_0: assert property(check_frame (v0,s0)) 
                             else $display("%m Bad frame received.");
  
*/
endmodule  
