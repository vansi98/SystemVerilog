`ifndef __VIRTUAL_RESET_SEQUENCE__SV__
`define __VIRTUAL_RESET_SEQUENCE__SV__

class virtual_reset_sequencer extends uvm_sequencer;
  `uvm_component_utils(virtual_reset_sequencer)
  reset_sequencer  r_seqr;
  packet_sequencer pkt_seqr[$];

  // Lab 7 - Task 3, Step 3
  //
  // Declare a host_sequencer handle called h_seqr
  //
  // host_sequencer h_seqr;
  //
  // ToDo


  function new(string name, uvm_component parent);
    super.new(name, parent);    
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction
endclass

class virtual_reset_sequence extends uvm_sequence;
  `uvm_object_utils(virtual_reset_sequence)
  `uvm_declare_p_sequencer(virtual_reset_sequencer)

  reset_sequence         r_seq;
  driver_reset_sequence  d_seq;
  uvm_event reset_event = uvm_event_pool::get_global("reset");

  // Lab 7 - Task 3, Step 5
  //
  // In this virtual sequence you will need to add one more sequence execution: host_reset_sequence
  //
  // Create a host_reset_sequence handle called h_seq
  //
  // host_reset_sequence    h_seq;
  //
  // ToDo



  function new(string name="virtual_reset_sequence");
    super.new(name);    
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual task pre_start();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.raise_objection(this);
    end
  endtask

  virtual task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    fork
      `uvm_do_on(r_seq, p_sequencer.r_seqr);
      foreach (p_sequencer.pkt_seqr[i]) begin
        int j = i;
        fork
          begin
            reset_event.wait_on();
            `uvm_do_on(d_seq, p_sequencer.pkt_seqr[j]);
          end
        join_none
      end

      // Lab 7 - Task 3, Step 6
      //
      // This virtual sequence need to execute one more sequence when reset
      // is detected: the host_reset_sequence,
      //
      // begin
      //   reset_event.wait_on();
      //   `uvm_do_on(h_seq, p_sequencer.h_seqr);
      // end
      //
      // ToDo




    join
  endtask

  virtual task post_start();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.drop_objection(this);
    end
  endtask
endclass
`endif
