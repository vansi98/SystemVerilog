`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`include "router_env.sv"

class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  router_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = router_env::type_id::create("env", this);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();
    factory.print();
  endfunction: start_of_simulation_phase
endclass: test_base

class print_test extends test_base;
  `uvm_component_utils(print_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_default_printer = uvm_default_line_printer;
  endfunction: new
endclass
`endif

