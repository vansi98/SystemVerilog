`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"

class packet_base_sequence extends uvm_sequence #(packet);
  `uvm_object_utils(packet_base_sequence)

  function new(string name = "packet_base_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task pre_start();
    if (get_parent_sequence() == null && starting_phase != null)
      starting_phase.raise_objection(get_sequencer());
  endtask

  virtual task post_start();
    if (get_parent_sequence() == null && starting_phase != null)
      starting_phase.drop_objection(get_sequencer());
  endtask
endclass

class packet_sequence extends packet_base_sequence;
  packet pkt_in_drv[int];
  int packet_transaction_id;
  int item_count = 10;

  `uvm_object_utils_begin(packet_sequence)
    `uvm_field_aa_object_int(pkt_in_drv, UVM_ALL_ON)
    `uvm_field_int(packet_transaction_id, UVM_ALL_ON)
    `uvm_field_int(item_count, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "packet_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  task body();
    packet_transaction_id = 0;
    uvm_config_db#(int)::get(m_sequencer, this.get_type_name(), "item_count", item_count);
    repeat(item_count) begin
      if (pkt_in_drv.size() >= 5) begin
        `uvm_info("PKT_Q_SIZE", "About to be halted", UVM_MEDIUM);
      end
      wait(pkt_in_drv.size() < 5);
      `uvm_create_on(req, m_sequencer);
      req.set_transaction_id(packet_transaction_id++);
      start_item(req);
      if (!req.randomize()) begin
        `uvm_fatal("RAND_ERR", "packet_sequence failed randomization");
      end
      pkt_in_drv[req.get_transaction_id()] = req;
      fork
        packet in_driver = req;
        begin
          packet from_driver;
          get_response(from_driver, in_driver.get_transaction_id());
          // process response
          pkt_in_drv.delete(from_driver.get_transaction_id());
        end
      join_none
      `uvm_info("PKT__SEQ", {"\n", req.sprint()}, UVM_MEDIUM);
      finish_item(req);
    end
    wait(pkt_in_drv.size() == 0);
  endtask: body

endclass: packet_sequence

`endif
