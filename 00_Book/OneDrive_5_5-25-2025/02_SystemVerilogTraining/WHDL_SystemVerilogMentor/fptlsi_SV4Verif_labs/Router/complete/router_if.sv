interface router_if(input logic clock);
  import defs::*;
  logic  rst ;
  logic [7:0] valid ;
  logic [7:0] stream ;
  logic [7:0] streamo ;
  logic [7:0] busy ;
  logic [7:0] valido ;

//  modport TB(clocking cb, output rst, output clock);
modport TB(
    output  rst,
    output  valid,
    output  stream,
    output  clock,
    input  streamo,
    input  busy,
    input  valido );

endinterface: router_if
