`ifndef __VIRTUAL_RESET_SEQUENCE__SV__
`define __VIRTUAL_RESET_SEQUENCE__SV__

//
// The following virtual sequencer has been created for your in order to save
// lab time.
//
// A virtual sequencer typically only contains a list of sequencers needed
// to be managed by the virtual sequence.
//
// In this particular case, there are two sequencer types that need to be
// managed: reset_sequencer and packet_sequencer.  Within the DUT, there is
// only one reset_sequencer but multiple packet_sequencers.  Because of
// that, a queue of packet_sequencers is declared.
//
 
class virtual_reset_sequencer extends uvm_sequencer;
  `uvm_component_utils(virtual_reset_sequencer)
  reset_sequencer  r_seqr;
  packet_sequencer pkt_seqr[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);    
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction
endclass


//
// The following is the virtual sequence that you will need to populate to
// manage the reset sequence execution order.
//

class virtual_reset_sequence extends uvm_sequence;
  `uvm_object_utils(virtual_reset_sequence)

  // Lab 6 - Task 1, Step 4
  //
  // Use the `uvm_declare_p_sequencer macro to make the sequencer declared
  // above the parent sequencer type of this sequence.
  //
  // `uvm_declare_p_sequencer(virtual_reset_sequencer)
  //
  // ToDo
  `uvm_declare_p_sequencer(virtual_reset_sequencer)


  // Lab 6 - Task 1, Step 5
  //
  // In this virtual sequence you will need to manage two types of sequence
  // execution: reset_sequence and driver_reset_sequence.
  //
  // Create a handle of each type here.  Call the reset_sequence handle r_seq
  // And call the driver_reset_sequence handle d_seq.
  //
  // reset_sequence         r_seq;
  // driver_reset_sequence  d_seq;
  //
  // ToDo
  reset_sequence         r_seq;
  driver_reset_sequence  d_seq;


  // Lab 6 - Task 4, Step 6
  //
  // Add the "reset" uvm_event singleton object to the class.
  //
  // uvm_event reset_event = uvm_event_pool::get_global("reset");
  //
  // ToDo
  uvm_event reset_event = uvm_event_pool::get_global("reset");

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

    // Lab 6 - Task 1, Step 6
    //
    // This virtual sequence need to execute the reset_sequence first,
    // followed by the execution of the driver_reset_sequence
    //
    // Code the following:  (Code it as shown.  Don't worry if you disagree
    // with the implementation.  It is done this way with a reason.)
    //
    // `uvm_do_on(r_seq, p_sequencer.r_seqr);
    // foreach (p_sequencer.pkt_seqr[i]) begin
    //   `uvm_do_on(d_seq, p_sequencer.pkt_seqr[i]);
    // end
    //
    // ToDo
/*
    `uvm_do_on(r_seq, p_sequencer.r_seqr);
    foreach (p_sequencer.pkt_seqr[i]) begin
      `uvm_info("V_SEQ", $sformatf("p_sequencer.pkt_seqr[%0d]", i), UVM_HIGH);
      `uvm_do_on(d_seq, p_sequencer.pkt_seqr[i]);
    end
*/

    // Lab 6 - Task 3, Step 2
    //
    // Comment out the above code.
    //
    // Then, replace the code with the following:
    //
    // fork
    //   `uvm_do_on(r_seq, p_sequencer.r_seqr);
    //   foreach (p_sequencer.pkt_seqr[i]) begin
    //     int j = i;
    //     fork
    //       `uvm_do_on(d_seq, p_sequencer.pkt_seqr[j]);
    //     join_none
    //   end
    // join
    //
    // ToDo
/*
    fork
      `uvm_do_on(r_seq, p_sequencer.r_seqr);
      foreach (p_sequencer.pkt_seqr[i]) begin
        int j = i;
        fork
          `uvm_do_on(d_seq, p_sequencer.pkt_seqr[j]);
        join_none
      end
    join
*/

    // Lab 6 - Task 4, Step 7
    //
    // Comment out the above code.
    //
    // Then, replace the code with the following:
    //
    // fork
    //   `uvm_do_on(r_seq, p_sequencer.r_seqr);
    //   foreach (p_sequencer.pkt_seqr[i]) begin
    //     int j = i;
    //     fork
    //       begin
    //         reset_event.wait_on();
    //         `uvm_do_on(d_seq, p_sequencer.pkt_seqr[j]);
    //       end
    //     join_none
    //   end
    // join
    //
    // ToDo
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
