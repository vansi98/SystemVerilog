`ifndef DRIVER_RESET_SEQUENCE__SV
`define DRIVER_RESET_SEQUENCE__SV

class driver_reset_sequence extends uvm_sequence #(packet);
  virtual router_tb_io sigs;          // DUT virtual interface
  int                  port_id = -1;  // Driver's designated port

  `uvm_object_utils_begin(driver_reset_sequence)
    `uvm_field_int(port_id, UVM_DEFAULT | UVM_DEC)
  `uvm_component_utils_end

  function new(string name="driver_reset_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task pre_start();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.raise_objection(this);
    end
    uvm_config_db#(int)::get(get_sequencer(), "", "port_id", port_id);
    if (!(port_id inside {-1, [0:15]})) begin
      `uvm_fatal("CFGERR", $sformatf("port_id must be {-1, [0:15]}, not %0d!", port_id));
    end
    `uvm_info("DRV_RST_SEQ", $sformatf("Using port_id = %0d", port_id), UVM_MEDIUM);
    uvm_config_db#(virtual router_tb_io)::get(get_sequencer(), "", "sigs", sigs);
    if (sigs == null) begin
      `uvm_fatal("CFGERR", "Interface for the Driver Reset Sequence not set");
    end
  endtask: pre_start

  virtual task post_start();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.drop_objection(this);
    end
  endtask: post_start


  // Lab 4
  //
  // The components within the input_agent is fully responsible for asserting and
  // de-asserting the control signals that it is assigned to handle.
  //
  // Caution: for this lab, we are not using the port_id because this lab is still
  // just a part of initial bringup process.  There is only one agent in the
  // environment.  So, if port_id is -1 (not using port_id), then the reset phases
  // will initialized the signals for all router (DUT) ports.  In the next lab,
  // when you implement a dedicated agent for each port, the port_id will be set
  // and the reset phases will only initialize its designated port.
  //
  virtual task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (port_id == -1) begin
      sigs.frame_n = '1;
      sigs.valid_n = '1;
      sigs.din = '0;
    end else begin
      sigs.frame_n[port_id] = '1;
      sigs.valid_n[port_id] = '1;
      sigs.din[port_id] = '0;
    end
  endtask: body

endclass: driver_reset_sequence

`endif
