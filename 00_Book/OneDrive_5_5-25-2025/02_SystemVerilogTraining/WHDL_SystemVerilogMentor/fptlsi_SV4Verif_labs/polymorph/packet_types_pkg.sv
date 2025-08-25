package packet_types_pkg;

virtual class Packet ;
  byte unsigned payload[];
  byte unsigned crc;
  int pkt_id;
  static int num_pkts = 1;
  
  function new();
    pkt_id = num_pkts++;
  endfunction
  
  pure virtual function void gen_crc(); //endfunction
  pure virtual function bit check_crc(); //endfunction
  
  function void print_payload();
    for (int i=0; i<payload.size(); i++)
      $display(payload[i]);
  endfunction
  
  function void init_pkt(int sz);
    payload = new[sz];
    for (int i = 0; i<sz; i++)
      payload[i] = $random() % 256;
    gen_crc();    
//    crc++; // insert error by uncommenting this line
  endfunction 
endclass

//**************
// Your code here




endpackage
