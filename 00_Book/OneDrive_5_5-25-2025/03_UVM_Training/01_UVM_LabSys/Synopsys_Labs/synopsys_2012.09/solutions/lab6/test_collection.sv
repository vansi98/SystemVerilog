`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`include "router_env.sv"

class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  router_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = router_env::type_id::create("env", this);

    uvm_config_db#(virtual router_tb_io)::set(this, "env.i_agent[*]", "sigs", router_test_top.router_if.agent_vif);
    uvm_config_db#(virtual router_tb_io)::set(this, "env.o_agent[*]", "sigs", router_test_top.router_if.agent_vif);
    uvm_config_db#(virtual reset_tb_io)::set(this, "env.r_agent", "sigs", router_test_top.reset_if.agent_vif);
  endfunction

  virtual task main_phase(uvm_phase phase);
    uvm_objection objection;
    super.main_phase(phase);

    objection = phase.get_objection();
    objection.set_drain_time(this, 1us);
  endtask

  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();

    factory.print();
  endfunction
endclass

`include "packet_da_3.sv"

class test_da_3_inst extends test_base;
  `uvm_component_utils(test_da_3_inst)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    // The following has been changed from previous lab to configure all agents
    set_inst_override_by_type("env.i_agent[*].seqr.*", packet::get_type(), packet_da_3::get_type());
  endfunction
endclass

class test_da_3_type extends test_base;
  `uvm_component_utils(test_da_3_type)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    set_type_override_by_type(packet::get_type(), packet_da_3::get_type());
  endfunction
endclass

class test_da_3_seq extends test_base;
  `uvm_component_utils(test_da_3_seq)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    // The following has been changed from previous lab to configure all agents
    uvm_config_db#(bit[15:0])::set(this, "env.i_agent[*].seqr.packet_sequence", "da_enable", 16'h0008);
    uvm_config_db#(int)::set(this, "env.i_agent[*].seqr.packet_sequence", "item_count", 20);
  endfunction
endclass

`endif

