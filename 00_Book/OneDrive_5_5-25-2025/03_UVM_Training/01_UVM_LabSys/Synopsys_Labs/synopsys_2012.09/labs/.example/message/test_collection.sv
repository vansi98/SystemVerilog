`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`include "router_env.sv"
`include "new_report_server.sv"

class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  router_env env;
  new_report_server report_server;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    report_server = new();
    uvm_pkg::uvm_report_server::set_server(report_server);
    env = router_env::type_id::create("env", this);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();
    factory.print();
  endfunction: start_of_simulation_phase
endclass: test_base
`endif

