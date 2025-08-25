typedef struct{ logic [9:0] addr;
                        logic[31:0] data;
                      } global_pkt;
global_pkt unit_pkt;

task global_task (input global_pkt in1);
   $display($stime,,"addr: %h, data: %h",in1.addr, in1.data);
endtask

module code;
logic [7:0] x;

global_pkt y;

initial
  begin
   #20; 
   y.data = 2;
   y.addr = 2;
   global_task(y);
   
   #10; 
   unit_pkt.data = 3;            
   unit_pkt.addr = 3;		
   global_task(unit_pkt);	
   
  end

endmodule

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
