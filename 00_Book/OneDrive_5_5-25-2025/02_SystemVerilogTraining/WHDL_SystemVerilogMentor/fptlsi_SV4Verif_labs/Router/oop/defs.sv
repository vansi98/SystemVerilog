
package defs;
  bit [7:0] passthru; 
  bit pt_mode;  // pass thru mode bit

//*****************************  
class BasePacket;
  string name;
  bit[2:0] srce;
  bit[7:0] pkt_id;
  bit[2:0] dest;
  reg[7:0] payload[];


  function new(string name = "Packet Object");
    this.name = name;
    payload = new[1];
  endfunction


  function void display(string prefix = "NOTE");
    int i;
    $display("%0d [%s] %s: srce = %0d, dest = %0d", $stime,prefix, name, srce, dest);
    $display("%0d [%s] %s: payload size = %0d",$stime, prefix, name, payload.size());
    for (i=0; i<payload.size(); i++)
      $display("%0d [%s] %s: payload[%0d] = %0h",$stime, prefix, name, i, payload[i]);
  endfunction


endclass

//*******************************
// Put class here




endpackage


