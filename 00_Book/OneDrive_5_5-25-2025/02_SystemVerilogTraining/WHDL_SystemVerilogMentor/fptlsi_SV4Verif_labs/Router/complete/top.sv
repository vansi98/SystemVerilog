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

endmodule  
