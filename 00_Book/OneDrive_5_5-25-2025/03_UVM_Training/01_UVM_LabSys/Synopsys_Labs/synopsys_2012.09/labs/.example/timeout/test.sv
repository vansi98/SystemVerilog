program automatic test;
import uvm_pkg::*;

`include "test_collection.sv"

initial begin
  $timeformat(-9, 1, "ns", 10);
  run_test();
end

initial begin
  #1s;
  #1s;
end

endprogram

