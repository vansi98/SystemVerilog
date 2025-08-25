`ifndef ROUTER_ENV__SV
`define ROUTER_ENV__SV

`include "input_agent.sv"
`include "reset_agent.sv"
`include "driver_reset_sequence.sv"
`include "output_agent.sv"
`include "ms_scoreboard.sv"

// Lab 7 - Task 4, Step 2
//
// Include the host_agent.sv file.
//
// `include "host_agent.sv"
//
// ToDo



`include "virtual_reset_sequence.sv"

class router_env extends uvm_env;
  reset_agent r_agent;
  input_agent i_agent[16];
  output_agent o_agent[16];
  scoreboard sb;
  virtual_reset_sequencer  v_reset_seqr;

  // Lab 7 - Task 4, Step 3
  //
  // Declare a host_agent handle called h_agent
  //
  // host_agent  h_agent;
  //
  // ToDo



  // Lab 7 - Task 11, Step 2
  //
  // Declare a ral_block_host_regmodel handle called regmodel
  // Declare a reg_adapter handle called adapter
  //
  // ral_block_host_regmodel regmodel;
  // reg_adapter adapter;
  //
  // ToDo



  // Lab 7 - Task 16, Steps 2 & 3
  //
  // Explicit prediction of the DUT register content should also be implemented.
  //
  // use typedef to create a predictor called hreg_predictor then declared a
  // handle called hreg_predict.
  //
  // typedef uvm_reg_predictor #(host_data) hreg_predictor;
  // hreg_predictor hreg_predict;
  //
  // ToDo




  `uvm_component_utils(router_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    r_agent = reset_agent::type_id::create("r_agent", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "r_agent.seqr.reset_phase", "default_sequence", null);

    foreach (i_agent[i]) begin
      i_agent[i] = input_agent::type_id::create($sformatf("i_agent[%0d]", i), this);
      uvm_config_db #(int)::set(this, i_agent[i].get_name(), "port_id", i);
      uvm_config_db #(uvm_object_wrapper)::set(this, {i_agent[i].get_name(), ".", "seqr.reset_phase"}, "default_sequence", null);
      uvm_config_db #(uvm_object_wrapper)::set(this, {i_agent[i].get_name(), ".", "seqr.main_phase"}, "default_sequence", packet_sequence::get_type());
    end

    uvm_config_db #(uvm_object_wrapper)::set(this, "v_reset_seqr.reset_phase", "default_sequence", virtual_reset_sequence::get_type());

    sb = scoreboard::type_id::create("sb", this);

    foreach (o_agent[i]) begin
      o_agent[i] = output_agent::type_id::create($sformatf("o_agent[%0d]", i), this);
      uvm_config_db #(int)::set(this, o_agent[i].get_name(), "port_id", i);
    end

    v_reset_seqr = virtual_reset_sequencer::type_id::create("v_reset_seqr", this);

    // Lab 7 - Task 4, Step 4
    //
    // Construct the h_agent object
    //
    // h_agent = host_agent::type_id::create("h_agent", this);
    //
    // ToDo



    // Lab 7 - Task 11, Step 3
    //
    // Construct the adapter object
    //
    // adapter = reg_adapter::type_id::create("adapter", this);
    //
    // ToDo



    // Lab 7 - Task 11, Step 4, 5 & 6
    //
    // Try to retrieve regmodel from configuration data base.  If not found,
    // construct and set up the regmodel. In all cases, setup the h_agent to use the regmodel.
    //
    // uvm_config_db #(ral_block_host_regmodel)::get(this, "", "regmodel", regmodel);
    //
    // if (regmodel == null) begin
    //   string hdl_path;
    //   `uvm_info("HOST_CFG", "Self constructing regmodel", UVM_MEDIUM);
    //   if (!uvm_config_db #(string)::get(this, "", "hdl_path", hdl_path)) begin
    //     `uvm_warning("HOST_CFG", "HDL path for DPI backdoor not set!");
    //   end
    //   regmodel = ral_block_host_regmodel::type_id::create("regmodel", this);
    //   regmodel.build();
    //   regmodel.lock_model();
    //   regmodel.set_hdl_path_root(hdl_path);
    // end
    //
    // uvm_config_db #(ral_block_host_regmodel)::set(this, h_agent.get_name(), "regmodel", regmodel);
    //
    // ToDo











    // Lab 7 - Task 14, Step 5
    //
    // Set the host agent to execute the ral_port_unlock_sequence at the configure phase:
    //
    // uvm_config_db #(uvm_object_wrapper)::set(this, {h_agent.get_name(), ".", "seqr.configure_phase"}, "default_sequence", ral_port_unlock_sequence::get_type());
    //
    // ToDo



    // Lab 7 - Task 16, Step 4
    //
    // Construct the predictor object.
    //
    // hreg_predict = hreg_predictor::type_id::create("h_reg_predict", this);
    //
    // ToDo



  endfunction

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    foreach (i_agent[i]) begin
      i_agent[i].analysis_port.connect(sb.before_export);
      v_reset_seqr.pkt_seqr.push_back(i_agent[i].seqr);
    end

    foreach (o_agent[i]) begin
      o_agent[i].analysis_port.connect(sb.after_export);
    end

    v_reset_seqr.r_seqr = this.r_agent.seqr;

    // Lab 7 - Task 4, Step 5
    //
    // Set the virtual reset sequencer's h_seqr handle to the host agent's seqr handle.
    //
    // v_reset_seqr.h_seqr = this.h_agent.seqr;
    //
    // ToDo



    // Lab 7 - Task 11, Step 7
    //
    // Set up the regmodel's address map to apply the proper adaptor to the
    // corresponding sequencer.
    //
    // regmodel.default_map.set_sequencer(h_agent.seqr, adapter);
    //
    // ToDo



    // Lab 7 - Task 16, Step 5
    //
    // Set the predictor's map to the regmodel's map.
    // Set the predictor's adapter to the adapter being used by the sequencer.
    // Finally connect the host_agent's analysis por to the predictor's bus_in
    // analysis port.
    //
    // hreg_predict.map = regmodel.get_default_map();
    // hreg_predict.adapter = adapter;
    // h_agent.analysis_port.connect(hreg_predict.bus_in);
    //
    // ToDo





  endfunction

endclass

`endif
