`ifndef SCOREBOARD__SV
`define SCOREBOARD__SV

class transformer extends uvm_object;
  `uvm_object_utils(transformer)

  function new(string name="transformer");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  function packet transform(packet tr);
    transform = tr;
  endfunction
endclass

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  typedef uvm_algorithmic_comparator #(packet, packet, transformer) comparator;
//  typedef uvm_in_order_class_comparator #(packet) comparator;

  comparator  compr;
  transformer trans;

  uvm_analysis_export #(packet) before_export;
  uvm_analysis_export #(packet) after_export;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    trans = transformer::type_id::create("trans", this);
    compr = new("compr", this, trans);
    before_export = new("before_export", this);
    after_export = new("after_export", this);
    before_export.connect(compr.before_export);
    after_export.connect(compr.after_export);
  endfunction

  virtual function void report_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
//    `uvm_info("Scoreboard Report", $sformatf("Comparator Matches = %0d, Mismatches = %0d", compr.m_matches, compr.m_mismatches), UVM_MEDIUM);
  endfunction
endclass

`endif

