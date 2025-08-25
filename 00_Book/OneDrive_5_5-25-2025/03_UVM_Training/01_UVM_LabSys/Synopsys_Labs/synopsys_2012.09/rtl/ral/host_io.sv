`ifndef HOST_IO__SV
`define HOST_IO__SV

interface host_tb_io(input logic clk, ref logic wr_n, rd_n, inout wire [15:0] data, address);
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
endinterface: host_tb_io

interface host_io(input logic clk);
  logic        wr_n, rd_n;
  wire  [15:0] address;
  wire  [15:0] data;

  host_tb_io agent_vif(clk, wr_n, rd_n, data, address);

  modport dut(input wr_n, rd_n, inout data, address);
endinterface: host_io
`endif
