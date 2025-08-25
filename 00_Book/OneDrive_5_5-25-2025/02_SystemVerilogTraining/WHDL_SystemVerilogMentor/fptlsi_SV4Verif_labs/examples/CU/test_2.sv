module test_2;

logic unit_pkt;  // local variable hides global

code U1();

initial
  begin
   #10; 
   $unit::unit_pkt.data = 1;    // $unit:: needed here   
   $unit::unit_pkt.addr = 1;	
   global_task($unit::unit_pkt);
  end
endmodule
