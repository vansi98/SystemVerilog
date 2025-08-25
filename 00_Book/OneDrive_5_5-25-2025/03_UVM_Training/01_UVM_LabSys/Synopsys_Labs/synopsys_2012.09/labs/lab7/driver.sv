`ifndef DRIVER__SV
`define DRIVER__SV

class driver extends uvm_driver #(packet);
  virtual router_tb_io sigs;          // DUT virtual interface
  int                  port_id = -1;  // Driver's designated port

  `uvm_component_utils_begin(driver)
    `uvm_field_int(port_id, UVM_DEFAULT | UVM_DEC)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    uvm_config_db#(int)::get(this, "", "port_id", port_id);
    if (!(port_id inside {-1, [0:15]})) begin
      `uvm_fatal("CFGERR", $sformatf("port_id must be {-1, [0:15]}, not %0d!", port_id));
    end
    uvm_config_db#(virtual router_tb_io)::get(this, "", "sigs", sigs);
    if (sigs == null) begin
      `uvm_fatal("CFGERR", "Interface for Driver not set");
    end
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    `uvm_info("DRV_CFG", $sformatf("port_id is: %0d", port_id), UVM_MEDIUM);
  endfunction: start_of_simulation_phase

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    forever begin
      seq_item_port.get_next_item(req);

      if (port_id inside { -1, req.sa }) begin
        send(req);
        `uvm_info("DRV_RUN", {"\n", req.sprint()}, UVM_MEDIUM);
      end

      seq_item_port.item_done();
    end
  endtask: run_phase

  virtual task send(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    send_address(tr);
    send_pad(tr);
    send_payload(tr);
  endtask: send

  virtual task send_address(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    sigs.drvClk.frame_n[tr.sa] <= 1'b0;
    for(int i=0; i<4; i++) begin
      sigs.drvClk.din[tr.sa] <= tr.da[i];
      @(sigs.drvClk);
    end
  endtask: send_address

  virtual task send_pad(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    sigs.drvClk.din[tr.sa] <= 1'b1;
    sigs.drvClk.valid_n[tr.sa] <= 1'b1;
    repeat(5) @(sigs.drvClk);
  endtask: send_pad

  virtual task send_payload(packet tr);
    logic [7:0] datum;
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    while(!sigs.drvClk.busy_n[tr.sa]) @(sigs.drvClk);
    foreach(tr.payload[index]) begin
      datum = tr.payload[index];
      for(int i=0; i<$size(tr.payload, 2); i++) begin
        sigs.drvClk.din[tr.sa] <= datum[i];
        sigs.drvClk.valid_n[tr.sa] <= 1'b0;
        sigs.drvClk.frame_n[tr.sa] <= ((tr.payload.size()-1) == index) && (i==7);
        @(sigs.drvClk);
      end
    end
    sigs.drvClk.valid_n[tr.sa] <= 1'b1;
  endtask: send_payload

endclass: driver

`endif
