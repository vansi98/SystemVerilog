module mbox;
import types::*;

//Declare two mailboxes here




// This task supplies stimulus to the two mailboxes
task stimulus();
  packet stim_pkt;
  for (int i = 0; i < 256; i++) begin
    stim_pkt.pid = i;

    //*** Write stim_pkt to both mailboxes here


    $display("Sending pkt: ",i);
  end
endtask

// Add task checker here






// Add function compare here
  




// Add an intial block to run stimulus & checker tasks simultaneously    




endmodule
