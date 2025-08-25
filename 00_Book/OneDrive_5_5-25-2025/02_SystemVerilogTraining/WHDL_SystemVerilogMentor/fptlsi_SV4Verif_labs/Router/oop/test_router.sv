`define ROUTER_SIZE 8

import defs::*;

//**********************************
class base_scoreboard;
  mailbox #(Packet) stim_mb, mon_mb;
  Packet check [ int ];
  int s_pkt_cnt, m_pkt_cnt, pkt_mismatch;
  Packet s_pkt, m_pkt;
  int errors, run_for_n_packets;
  string name;
  bit[2:0] srce, dest;
  event smpl;

 function new(mailbox #(Packet) stim_mb = null, 
              mailbox #(Packet) mon_mb = null, 
	      int run_for_n_packets = 100 ); 
    this.stim_mb = stim_mb;
    this.mon_mb = mon_mb;
    this.run_for_n_packets = run_for_n_packets;
 endfunction : new

 task report();
    $display("\n%0d packets sent, %0d packets received, %0d errors\n", 
              s_pkt_cnt, m_pkt_cnt, pkt_mismatch);
 endtask : report

 virtual task automatic run1();
    while(1) begin
      stim_mb.get(s_pkt);
      ++s_pkt_cnt;
      
      check[s_pkt.pkt_id] = s_pkt;
      if(s_pkt_cnt == run_for_n_packets) begin
	break; // let the monitor finish off
      end
      else
      report;	
    end	 
 endtask	 	

 virtual task automatic run2();
   while(1) begin                                                                   
     mon_mb.get(m_pkt);                                                             
     ++m_pkt_cnt;                                                                   
     if (check.exists(m_pkt.pkt_id))                                                
       case( m_pkt.compare(check[m_pkt.pkt_id]) )                                   
         0: begin
              $display("Compare error",,m_pkt.pkt_id,, check[m_pkt.pkt_id].pkt_id);
              pkt_mismatch++; $stop;
            if(`TRACE_ON)                                                           
              s_pkt.display; check[s_pkt.pkt_id].display;                           
            end                                                                     
         1: begin
              check.delete(m_pkt.pkt_id);
              srce = s_pkt.srce;
              dest = s_pkt.dest;
            end
       endcase 
     else begin                                                                     
        check[m_pkt.pkt_id] = m_pkt;                                                
     end                                                                            
     report;                                                                        
    end
 endtask
 
 task automatic run();
   fork
     run1;
     run2;
   join_none
   #1;
 endtask

endclass : base_scoreboard

//****************************
class scoreboard extends base_scoreboard;

 function new(mailbox #(Packet) stim_mb = null, 
              mailbox #(Packet) mon_mb = null, 
	      int run_for_n_packets = 100 ); 
    this.stim_mb = stim_mb;
    this.mon_mb = mon_mb;
    this.run_for_n_packets = run_for_n_packets;
 endfunction : new

 task automatic run2();
    while(1) begin
      this.mon_mb.get(m_pkt);
      ++m_pkt_cnt;
      if (check.exists(m_pkt.pkt_id))
        case( m_pkt.compare(check[m_pkt.pkt_id]) )
	  0: begin
	       $display("Compare error",,m_pkt.pkt_id,, check[m_pkt.pkt_id].pkt_id);
	       pkt_mismatch++; $stop;
               if(`TRACE_ON) 
                 s_pkt.display; check[s_pkt.pkt_id].display;
             end
	  1: begin
	       check.delete(m_pkt.pkt_id);
	       srce = s_pkt.srce;
	       dest = s_pkt.dest;
	     end
	endcase 
      else begin
         check[m_pkt.pkt_id] = m_pkt;	
      end
      if(m_pkt_cnt == run_for_n_packets) begin
        report;
	$stop;
      end
      report;	
    end
 endtask

endclass : scoreboard


//*******************************
class monitor;
virtual router_if r_if;
int id;
reg[7:0] p_id;
bit[2:0] srce, dest;
reg[7:0] payload[$], pkt2cmp_payload[$];
Packet pktrecvd;

  mailbox #(Packet) log_mb;

  function new(int id, virtual router_if r_if, mailbox #(Packet) log_mb);
    this.id = id;
    this.r_if = r_if;
    this.log_mb = log_mb;
  endfunction 

 task automatic capture_payload();
  reg[7:0] datum;
  pkt2cmp_payload = '{};
  
  wait(r_if.valido[id])
  @(posedge r_if.clock);
  // get packet id first
  for(int i=7; i>=0; i--)                
    begin                                
      p_id[i] = r_if.streamo[id];        
      @(posedge r_if.clock);             
    end                                                                     
  while(r_if.valido[id]) 
    begin
      for(int i=7; i>=0; i--) 
        begin
          datum[i] = r_if.streamo[id];
          @(posedge r_if.clock);
        end
        pkt2cmp_payload.push_back(datum);
    end
  if(`TRACE_ON) 
    $display("Monitor %0d Received %0d ",id, pkt2cmp_payload.size()," bytes");
 endtask

 task automatic run();
  //
  // Since payload size can't be predicted, capture_payload() uses a queue 
  // This method converts from queue to Packet - pktrecvd
  //
  static int pkts_recvd;
  pkts_recvd = 0;

  $display("Starting Monitor %0d ",id);

  while(1) begin
    capture_payload();
    pktrecvd = new();
    pktrecvd.pkt_id = p_id;  // put in packet id
    pktrecvd.payload = new[pkt2cmp_payload.size()];
    for (int i=0; i<pkt2cmp_payload.size(); i++) begin
      pktrecvd.payload[i] = pkt2cmp_payload[i];
      if(`TRACE_ON)
        $display("Mon: %0d Packet Id: %0d	payload[%0d] = %0h Srce: %0d Dest: %d", id,
      pktrecvd.pkt_id, i,
      pktrecvd.payload[i], pktrecvd.srce, pktrecvd.dest) ;
    end  
    pktrecvd.dest = id;
    log_mb.put(pktrecvd);
  end
 endtask

endclass : monitor

//************************
class driver;
virtual router_if r_if;
int id;
bit[2:0] dest;
Packet pkt2send, pktrecvd;
 mailbox #(Packet) mb;

  function new(int id, virtual router_if r_if, mailbox #(Packet) mb);
    this.r_if = r_if;
    this.id = id;
    this.mb = mb;
  endfunction 

 task automatic run(); 

  while(1) begin
      mb.get(pkt2send);
      dest = pkt2send.dest;
      if(`TRACE_ON) begin
        $display($stime,"  Driver %0d: Packet ID: %0d Dest: %0d Size: %0h\n",id,
                    pkt2send.pkt_id, dest, pkt2send.payload.size());
        pkt2send.display();
      end	
      send_dest();
      send_payload();    
  end  
 endtask

 task automatic send_dest();
  @(posedge r_if.clock);
  r_if.valid[id] = 1;
  r_if.stream[id] = 1;
  @(posedge r_if.clock); 
  for(int i=2; i>=0; i--)
    begin
      r_if.stream[id] = dest[i]; 
      @(posedge r_if.clock);   
    end
  r_if.stream[id] = 0;
  wait(r_if.busy[id]);
 endtask

 task automatic send_payload();
   wait(!r_if.busy[id])

  // send packet ID first
  for(int i=7; i>=0; i--) begin
      r_if.stream[id] = pkt2send.pkt_id[i];
      @(posedge r_if.clock);
    end 
  // send payload
  for(int i=0; i<pkt2send.payload.size(); i++) 
    for(int j=7; j>=0; j--) begin
      r_if.stream[id] = pkt2send.payload[i][j];
    @(posedge r_if.clock); 
    end
  r_if.valid[id] = 0;
  r_if.stream[id] = 0;

 endtask
endclass :driver

//***********************
class stimulus;
 int id;
 Packet pkt2send;
 mailbox #(Packet) mb, log_mb;
 static int packet_id = 1;  
 
 function new( int id = 1, mailbox #(Packet) mb, mailbox #(Packet) log_mb ); 
   this.id = id; 
   this.mb = mb;
   this.log_mb = log_mb;               
 endfunction              

 task automatic run();
  static int pkts_generated;
  pkts_generated = 0;
  $display("Building random payload for port %0d...",id) ;
  
  while(1) begin
      pkt2send = new(packet_id++);
      pkt2send.srce = id;
      pkt2send.dest = ($random() % 8);
      pkt2send.payload[0] = $random();
      mb.put(pkt2send);     
      log_mb.put(pkt2send);   
      pkts_generated++;      
   end   
 endtask
 
endclass : stimulus

//****************
class test_env;
 // Declare virtual interface "r_if"
 virtual router_if  r_if;

 // create handles
 mailbox #(Packet) s2d_mb[];
 mailbox #(Packet) log_mon, log_stim;
 // dynamic array of handles
 stimulus	s[];
 driver		d[];
 monitor	m[];
 scoreboard     sb;
 
 function new(virtual router_if routr);

   // assign real interface instance to virtual interface "r_if"
   r_if = routr;

   // create packet logging mailboxes
   log_mon  = new();
   log_stim = new();
   
   // create scoreboard & configure internal handles
   sb = new(.stim_mb(log_stim), .mon_mb(log_mon), .run_for_n_packets(500));
   
   // size the dynamic arrays of monitor, driver and stimulus objects
   s      = new[`ROUTER_SIZE];
   d      = new[`ROUTER_SIZE];
   m      = new[`ROUTER_SIZE];
   s2d_mb = new[`ROUTER_SIZE];

   // Populate dynamic arrays & configure internal handles
   for ( int id = 0; id < `ROUTER_SIZE; id++)
     begin
       s2d_mb[id] = new(10);
       s[id] = new(.id(id), .mb(s2d_mb[id]), .log_mb(log_stim) );
       d[id] = new(.id(id), .mb(s2d_mb[id]), .r_if(r_if));
       m[id] = new(.id(id), .log_mb(log_mon), .r_if(r_if));
     end      
 endfunction
 
 task  run();
   // start everything
   for ( int id = 0; id < `ROUTER_SIZE; id++) begin
     fork
       m[id].run;
       d[id].run;
       s[id].run;
     join_none
     #1;
   end
   fork
       sb.run;
   join_none
   #1;
 endtask

endclass : test_env


//*****************
module test_router(router_if r_if);

test_env t_env; 
Packet pkt2send, pktrecvd;

initial begin
  reset();
  pt_mode = 0;        // set to not pass thru mode to start
  t_env = new(r_if);  //create test environment
  t_env.run;          // start things running
end

task reset();
  r_if.rst <= 1;
  r_if.valid <= 0;
  r_if.stream <= 0;
  repeat(2) @(posedge r_if.clock); //@(r_if.cb);
  r_if.rst <= 0;
  repeat(15) @(posedge r_if.clock); //@(r_if.cb);
endtask

endmodule
