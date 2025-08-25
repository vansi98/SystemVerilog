`ifndef DRIVER__SV
`define DRIVER__SV

class driver extends uvm_driver #(packet);
  `uvm_component_utils(driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task run_phase(uvm_phase phase);
    packet pkt_q[$];
    fork
      forever begin
        packet in_use;
        int index;
        #($urandom_range(1,5));
        wait (pkt_q.size() != 0);
        index = $urandom_range(pkt_q.size()-1);
        in_use = pkt_q[index];
`ifdef UVM_DISABLE_AUTO_ITEM_RECORDING
        begin_tr(in_use); // transaction recording
`endif
        // process transaction
        `uvm_info("DRV_START", {"\n", in_use.sprint()}, UVM_MEDIUM);
        #($urandom_range(10,20));
        pkt_q.delete(index);
        seq_item_port.put_response(in_use);
`ifdef UVM_DISABLE_AUTO_ITEM_RECORDING
        end_tr(in_use); // transaction recording
`endif
      end
    join_none
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRV_ACCEPT", {"\n", req.sprint()}, UVM_MEDIUM);
`ifdef UVM_DISABLE_AUTO_ITEM_RECORDING
      accept_tr(req); // transaction recording
`endif
      pkt_q.push_back(req);
      seq_item_port.item_done();
    end
  endtask: run_phase

endclass: driver

`endif

