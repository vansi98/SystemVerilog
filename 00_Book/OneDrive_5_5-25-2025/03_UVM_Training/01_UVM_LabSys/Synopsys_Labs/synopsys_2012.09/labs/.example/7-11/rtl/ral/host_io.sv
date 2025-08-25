`ifndef HOST_IO__SV
`define HOST_IO__SV

interface host_tb(ref logic clk, wr_n, rd_n, inout wire [15:0] data, address);
  clocking mst @(posedge clk);
    inout   data;
    output  address;
    output  wr_n;
    output  rd_n;
  endclocking

  clocking mon @(posedge clk);
    input  data;
    inout  address;
    input  wr_n;
    input  rd_n;
  endclocking
endinterface: host_tb

interface host_io(input logic clk);
  logic        wr_n, rd_n;
  wire  [15:0] address;
  wire  [15:0] data;

  host_tb agent_io(clk, wr_n, rd_n, data, address);

  modport dut(input clk, wr_n, rd_n, inout data, address);
endinterface: host_io
`endif
