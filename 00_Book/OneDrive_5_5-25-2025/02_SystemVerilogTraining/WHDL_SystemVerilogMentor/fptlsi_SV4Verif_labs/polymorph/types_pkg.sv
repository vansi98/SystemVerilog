package types_pkg;
import packet_types_pkg::*;

//**********************
// Your code here
// class source and class sink





//******************
class env;
  // create  channel between source & sink
  mailbox #(Packet) src2snk = new();  
  source src = new(5,5);  // create source obj - send 5 of each type of Packet
  sink snk = new(10);  // create sink obj - receive 10 Packets
  
  function void connect();
  src.out_chan = src2snk; //connect up src to mailbox 
  snk.in_chan = src2snk;  //connect up snk to mailbox
  endfunction
  
  task automatic run();
    fork
      snk.run(); // start up sink
      src.run(); // start up source
    join_none
  endtask
endclass  //env


endpackage
