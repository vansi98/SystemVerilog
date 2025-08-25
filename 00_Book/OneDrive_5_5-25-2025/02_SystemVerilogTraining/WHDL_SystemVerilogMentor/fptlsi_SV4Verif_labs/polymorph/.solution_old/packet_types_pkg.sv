package packet_types_pkg;

virtual class Packet ;
  local byte unsigned payload[];
  local byte unsigned crc;
  int pkt_id;
  static int num_pkts = 1;
  
  function new();
    pkt_id = num_pkts++;
  endfunction
  
  virtual function void gen_crc(); endfunction
  virtual function bit check_crc(); endfunction
  
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

class Pkt_type_1  extends Packet;
  function void gen_crc();
    for (int i=0; i<payload.size(); i++)
      crc ^= payload[i];
  endfunction
  
  function bit check_crc();
    byte unsigned crc_chk;
    for (int i=0; i<payload.size(); i++)
      crc_chk ^= payload[i];
    if (crc_chk == crc)
      return(1);
    else
      return(0);
  endfunction
endclass

class Pkt_type_2  extends Packet;
  function void gen_crc();
    for (int i=0; i<payload.size(); i++)
      crc = crc ~^ payload[i]; 
  endfunction
  
  virtual function bit check_crc();
    byte unsigned crc_chk;
    for (int i=0; i<payload.size(); i++)
      crc_chk = crc_chk ~^ payload[i];     
    if (crc_chk == crc)
      return(1);
    else
      return(0);
  endfunction  
endclass

endpackage
