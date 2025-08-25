package types_pkg;
import packet_types_pkg::*;

//**********************
class source;
  mailbox #(Packet) out_chan; // null handle
  int t1_num_packets;
  int t2_num_packets;
  
  function new(int t1_n_pkts, t2_n_pkts);
    t1_num_packets = t1_n_pkts;
    t2_num_packets = t2_n_pkts;
  endfunction 
   
 task run();
   Packet pkt_to_send; // base class handle
   Pkt_type_1 t1_pkt; //derived class handle
   Pkt_type_2 t2_pkt; //derived class handle
   fork
     for(int i = 0; i < t1_num_packets; i++) begin
       t1_pkt = new();  // create derived object
       send_pkt(t1_pkt, i);  // init & send packet
     end  
     for(int i = 0; i < t2_num_packets; i++) begin
       t2_pkt = new();  // create derived object
       send_pkt(t2_pkt, i);  // init & send packet
     end
    join  
 endtask
 
 task automatic send_pkt(input Packet pkt_to_send, int i);
     pkt_to_send.init_pkt(i);  // initialize packet     
     out_chan.put(pkt_to_send); // write out packet
     $display("source: Sent packet, id = %0d", pkt_to_send.pkt_id);  
 endtask  
endclass  // source

//***********************
class sink;
  mailbox #(Packet) in_chan; // null handle
  Packet r_pkts[int];
  int num_pkts;
  
  function new(int n_pkts);
    num_pkts = n_pkts;
  endfunction
   
  task run();
   Packet rcvd_pkt;
   for(int i = 0; i<num_pkts; i++) begin
     in_chan.get(rcvd_pkt);  // get Packet object
     if (rcvd_pkt.check_crc()) begin  // check crc
       $display("sink: Received a good packet, id = %0d",rcvd_pkt.pkt_id);
       r_pkts[rcvd_pkt.pkt_id] = rcvd_pkt;  //put in array
     end
     else
       $display("ERROR: Received a BAD packet, id = %0d",rcvd_pkt.pkt_id);      
   end
  endtask
endclass // sink

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
