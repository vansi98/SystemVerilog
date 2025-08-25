`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: start_of_simulation_phase

  virtual task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    uvm_top.set_timeout(.timeout(1ms), .overridable(1));
#1s;
    phase.drop_objection(this);
  endtask

  virtual task configure_phase(uvm_phase phase);
    phase.raise_objection(this);
    uvm_top.set_timeout(.timeout(3ms), .overridable(1));
#1s;
    phase.drop_objection(this);
  endtask

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    uvm_top.set_timeout(.timeout(7ms), .overridable(1));
#1s;
    phase.drop_objection(this);
  endtask

  virtual task shutdown_phase(uvm_phase phase);
    phase.raise_objection(this);
    uvm_top.set_timeout(.timeout(100ms), .overridable(1));
#1s;
    phase.drop_objection(this);
  endtask

endclass: test_base
`endif

