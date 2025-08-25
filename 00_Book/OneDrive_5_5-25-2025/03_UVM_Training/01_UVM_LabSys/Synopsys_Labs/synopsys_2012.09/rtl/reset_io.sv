`ifndef RESET_IO__SV
`define RESET_IO__SV

interface reset_tb_io(input logic clk, ref logic reset_n);
  clocking mst @(posedge clk);
    output reset_n;
  endclocking

  clocking mon @(posedge clk);
    input reset_n;
  endclocking
endinterface: reset_tb_io

interface reset_io(input logic clk);
  logic        reset_n;

  reset_tb_io agent_vif(clk, reset_n);

  modport dut(input reset_n);
endinterface: reset_io
`endif
