import packet_types_pkg::*;
class env;
  // create  channel between source & sink
  mailbox #(Packet) src2snk = new();  
  source src = new(5);  // create source obj - send 5 of each type of Packet
  sink snk = new(10);  // create sink obj - receive 10 Packets
  src.out_chan = src2snk; //connect up src to mailbox 
  snk.in_chan = src2snk;
  
  task automatic run();
    fork
      snk.run(); // start up sink
      src.run(); // start up source
    join_none
  endtask
endclass
