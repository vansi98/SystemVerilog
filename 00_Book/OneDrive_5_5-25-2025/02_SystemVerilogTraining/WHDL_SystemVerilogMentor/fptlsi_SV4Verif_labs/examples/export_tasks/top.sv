module top;
   logic clk = 0;
   simple_bus sb_intf(clk); 		// Instantiate the interface
   memMod mem(.a(sb_intf.slave)); 	// exports the Read and Write tasks
   cpuMod cpu(.b(sb_intf.master)); 	// imports the Read and Write tasks
endmodule
