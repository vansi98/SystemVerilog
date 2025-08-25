`ifndef INPUT_AGENT__SV
`define INPUT_AGENT__SV

`include "packet_sequence.sv"
`include "driver.sv"

typedef uvm_sequencer #(packet) packet_sequencer;

class input_agent extends uvm_agent;
  packet_sequencer seqr;
  driver drv;

  virtual router_tb_io sigs;
  int                  port_id = -1;

  `uvm_component_utils(input_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    seqr = packet_sequencer::type_id::create("seqr", this);
    drv  = driver::type_id::create("drv", this);

    // The following configuration database gets and sets are done for you.
    //
    // Higher layer structural components like the environment and test should
    // pass the configuration information to the agent via the configuration
    // database.  The agent would then use the information to configure its
    // child components.
    //
    // In this set of labs, we are configuring the individual fields of the component
    // directly for simplicity of implementation.  In real testbenches that you build,
    // you should encapsulate all fields of the individual component into separate
    // configuration classes.
    //
    // For example:  The driver class might have a driver_cfg class containing all its
    // configuration information.  The monitor class might have a monitor_cfg class
    // containing all its configuration information.  One would then develop an agent
    // configuration class (e.g. input_agent_cfg) which contains an instance of
    // driver_cfg and an instance of monitor_cfg.
    //
    // The environment or test level would then configure the agent with an
    // input_agent_cfg object.  The agent then extract the individual configuration
    // objects (e.g. driver_cfg, monitor_cfg) and pass them on to the child components
    // via the configuration database sets.

    uvm_config_db#(int)::get(this, "", "port_id", port_id);
    uvm_config_db#(virtual router_tb_io)::get(this, "", "sigs", sigs);

    uvm_config_db#(int)::set(this, "*", "port_id", port_id);
    uvm_config_db#(virtual router_tb_io)::set(this, "*", "sigs", sigs);

  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction: connect_phase
endclass: input_agent

`endif
