
package defs;
  bit [7:0] passthru; 
  bit pt_mode;  // pass thru mode bit

//*****************************  
class BasePacket;
  string name;
  bit[3:0] srce;
  bit[7:0] pkt_id;
  bit[3:0] dest;
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
class Packet extends BasePacket;

  
  function new(bit[7:0] p_id = 1);
    pkt_id = p_id;
  endfunction  

  function bit compare(Packet to ); 
    Packet pkt;

    if(to == null) begin
      $display("***No Target Compare Object!!!***");
      return(0);
    end
    if($cast(pkt, to)) begin
      if (this.payload.size() != pkt.payload.size()) begin
        $display("***Mismatching Payload Size!!!***",,this.payload.size(),,pkt.payload.size());
        return(0);
      end
      for (int i=0; i<this.payload.size(); i++) begin
        if (this.payload[i] == pkt.payload[i]) ;
        else begin
          $display("***Mismatching Payload Content!!!***");
          return(0);
        end
      end
      //$display("Sucessful Compare");
      return(1);
    end
    else
      $display("***Not Object of the same Class!!!***");
      return(0);
  endfunction

endclass


endpackage


