package types;
  typedef struct {
    string data;
  } packet_t;
  
  packet_t text [0:10] = '{
    '{"Mary had a little lamb"},
    '{"It's fleece was white as snow"},
    '{"and everywhere that Mary went"},
    '{"her lamb was sure to go."},
    '{""},
    '{"Three blind mice"},
    '{"See how they run!"},
    '{"They all ran after a farmer's wife"},
    '{"Who cut off their tails with a carving knife."},
    '{"Did you ever see such a thing in your life"},
    '{"as three blind mice?"}
  };
  
  event start;  
endpackage

//#########################################
// Define top level "backplane"
//#########################################
//

module top;
import types::*;  // import types

initial
begin
  #10;
  -> start;
end

link_if L1();
producer P1( .l(L1.link_wt_if));
consumer C1( .l(L1.link_rd_if));     

endmodule

