module test_1;

logic unit_pkt;  // local variable hides global

code U1();

initial
  begin
   #10; 
   unit_pkt.data = 1;    // $unit:: needed here   
   unit_pkt.addr = 1;	
   global_task(unit_pkt);
  end
endmodule
