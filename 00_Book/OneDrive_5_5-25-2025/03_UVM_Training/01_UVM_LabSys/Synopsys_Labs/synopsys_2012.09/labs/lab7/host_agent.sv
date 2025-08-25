`ifndef HOST_AGENT__SV
`define HOST_AGENT__SV

`include "host_sequence.sv"

typedef class host_driver;
typedef class host_monitor;

typedef uvm_sequencer #(host_data) host_sequencer;

class host_agent extends uvm_agent;
  uvm_analysis_port #(host_data) analysis_port;
  host_sequencer seqr;
  host_driver    drv;
  host_monitor   mon;

  `uvm_component_utils(host_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    if (is_active == UVM_ACTIVE) begin
      seqr = host_sequencer::type_id::create("seqr", this);
      drv  = host_driver::type_id::create("drv", this);
    end
    mon = host_monitor::type_id::create("mon", this);
    analysis_port = new("analysis_port", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
    mon.analysis_port.connect(this.analysis_port);
  endfunction
endclass


class host_driver extends uvm_driver #(host_data);
  `uvm_component_utils(host_driver)

  virtual host_tb_io sigs;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (!uvm_config_db#(virtual host_tb_io)::get(this.get_parent(), "", "sigs", sigs)) begin
      `uvm_fatal("CFGERR", "DUT host interface not set");
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("RUN", { "Before process\n", req.sprint() }, UVM_FULL);
      data_rw(req);
      rsp = host_data::type_id::create("rsp", this);
      rsp.set_id_info(req);
      `uvm_info("RUN", { "After process\n", req.sprint() }, UVM_FULL);
      seq_item_port.item_done();
    end
  endtask

  virtual task data_rw(host_data req);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (req.addr inside {['h4000:'h4fff]}) begin // emulating RAM access
      case(req.kind)
        host_data::READ: begin
                           sigs.rd_n    = '0;
                           sigs.address = req.addr;
                           @(sigs.mst);
                           req.data = sigs.mst.data;
                           sigs.rd_n    = '1;
                           sigs.address = 'z;
                         end
        host_data::WRITE: begin
                            sigs.wr_n    = '0;
                            sigs.data    = req.data;
                            sigs.address = req.addr;
                            @(sigs.mst);
                            sigs.wr_n    = '1;
                            sigs.data    = 'z;
                            sigs.address = 'z;
                          end
        default: begin `uvm_fatal("REGERR", "Not a valid Register Command"); end
      endcase
    end else begin // emulating register access
      case(req.kind)
        host_data::READ: begin
                           sigs.mst.rd_n    <= '0;
                           sigs.mst.address <= req.addr;
                           @(sigs.mst);
                           req.data = sigs.mst.data;
                           sigs.mst.rd_n    <= '1;
                           sigs.mst.address <= 'z;
                         end
        host_data::WRITE: begin
                            sigs.mst.wr_n    <= '0;
                            sigs.mst.data    <= req.data;
                            sigs.mst.address <= req.addr;
                            @(sigs.mst);
                            sigs.mst.wr_n    <= '1;
                            sigs.mst.data    <= 'z;
                            sigs.mst.address <= 'z;
                          end
        default: begin `uvm_fatal("REGERR", "Not a valid Register Command"); end
      endcase
    end
  endtask
endclass


class host_monitor extends uvm_monitor;
  uvm_analysis_port #(host_data) analysis_port;
  virtual host_tb_io sigs;
  host_data tr;

  `uvm_component_utils(host_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (!uvm_config_db#(virtual host_tb_io)::get(this.get_parent(), "", "sigs", sigs)) begin
      `uvm_fatal("CFGERR", "DUT host interface not set");
    end
    analysis_port = new("analysis_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    forever begin
      tr = host_data::type_id::create("tr", this);
      data_detect(tr);
      `uvm_info("HOST_MON", {"\n", tr.sprint()}, UVM_HIGH);
      analysis_port.write(tr);
    end
  endtask

  virtual task data_detect(host_data tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    fork
      begin
        fork
          wr_detect();
          rd_detect();
        join_any
        disable fork;
      end
    join
  endtask

  virtual task wr_detect();
    @(sigs.mon);
    wait(sigs.mon.wr_n == 0);
    tr.addr = sigs.mon.address;
    tr.data = sigs.mon.data;
    tr.kind = host_data::WRITE;
    `uvm_info("GOT_WRITE", {"\n", tr.sprint()}, UVM_FULL);
  endtask

  virtual task rd_detect();
    @(sigs.mon);
    wait(sigs.mon.rd_n == 0);
    tr.addr = sigs.mon.address;
    tr.data = sigs.mon.data;
    tr.kind = host_data::READ;
    `uvm_info("GOT_READ", {"\n", tr.sprint()}, UVM_FULL);
  endtask
endclass


`endif
