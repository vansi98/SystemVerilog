`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

// Lab 1: task 2, step 11 - bring in the environment class with: `include "router_env.sv"
//
// ToDo
`include "router_env.sv"

// Lab 1: task 1, step 2 - Declare the class test_base that extends uvm_test
//
// ToDo
class test_base extends uvm_test;

  // Lab 1: task 1, step 3 - register the class in factory via `uvm_component_utils macro
  //
  // ToDo
  `uvm_component_utils(test_base)

  // Lab 1: task 2, step 11 - Declare a handle named env of type router_env
  //
  // ToDo
  router_env env;

  // Lab 1: task 1, step 4 - Create the constructor with two argument: string name, and uvm_component parent
  //                         Call super.new() with these two arguments
  //                         Lastly, print a message with: `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  //
  // ToDo
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1: task 2, step 11 - Create a router environment object with: env = router_env::type_id::create("env", this);
    //
    // ToDo
    env = router_env::type_id::create("env", this);

  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1: task 2, step 11 - Call uvm_top.print_topology() to see the test topology
    // Note: If you want to see the topology as a tree format try: uvm_top.print_topology(uvm_default_tree_printer);
    //       Calling print_topology without any argument defaults to: print_topology(uvm_default_table_printer);
    //       Try out both foramts to see what the differences are
    //
    // ToDo
    uvm_top.print_topology();

    // Lab 1: task 1, step 5 - Call factory.print() to see all classes registered with the factory
    //
    // ToDo
    factory.print();




    // Note: In the above code, there are two uvm_pkg specific object handles
    // being used directly: uvm_top and factory.
    //
    // In the labs, to simplify coding, you are accessing them directly.
    //
    // In general coding practive, this may not be a good idea.  The reason
    // is that by accessing these handles directly, you are taking a chance
    // on name collison.
    // 
    // A better approach for access these handles is to declare these
    // handles with unique name locally and retrieve the handle via the
    // get() method of the class.
    //
    // Example:
    // uvm_root    test_manager = uvm_root::get();    // Afterwards, use test_manager in place of uvm_top
    // uvm_factory test_factory = uvm_factory::get(); // Afterwards, use test_factory in place of factory

  endfunction: start_of_simulation_phase

endclass: test_base
`endif

