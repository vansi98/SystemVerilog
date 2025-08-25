`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`define comp_new \
  function new(string name, uvm_component parent); \
    super.new(name, parent); \
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH); \
  endfunction: new

typedef class environment;
typedef class agent;
typedef class sequencer;
typedef class driver;
typedef class monitor;
typedef class env_config;
typedef class agt_config;
typedef class comp_config;

class test_base extends uvm_test;
  env_config  cfg;
  environment env;

  `uvm_component_utils(test_base)
  `comp_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = environment::type_id::create("env", this);
    cfg = env_config::type_id::create("cfg", this);
    cfg.randomize();
    uvm_config_db#(env_config)::set(this, "env", "cfg", cfg);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("TEST", {"\n", this.sprint()}, UVM_MEDIUM);
  endfunction: start_of_simulation_phase

  virtual function void final_phase(uvm_phase phase);
    factory.print();
  endfunction
endclass: test_base

class drv_0_cfg extends comp_config;
  `uvm_component_utils(drv_0_cfg)
  `comp_new
  constraint port0{port_number == 0;}
endclass: drv_0_cfg

class test_drv0 extends test_base;
  `uvm_component_utils(test_drv0)
  `comp_new
  virtual function void build_phase(uvm_phase phase);
    set_inst_override_by_type("cfg.agt_cfg.drv_cfg", comp_config::get_type(), drv_0_cfg::get_type());
    super.build_phase(phase);
  endfunction
endclass: test_drv0

class test_drv7_set extends test_base;
  `uvm_component_utils(test_drv7_set)
  `comp_new
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg.agt_cfg.drv_cfg.port_number = 7;
  endfunction
endclass: test_drv7_set

class test_drv15_cfg extends test_base;
  comp_config drv_cfg;
  `uvm_component_utils(test_drv15_cfg)
  `comp_new
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv_cfg = comp_config::type_id::create("drv_cfg", this);
    drv_cfg.randomize() with {port_number == 15;};
    uvm_config_db#(comp_config)::set(this, "env.agt.drv", "cfg", drv_cfg);
  endfunction
endclass: test_drv15_cfg

class env_config extends uvm_component;  // common work around for access to hierarchy
  rand agt_config agt_cfg;
  `uvm_component_utils(env_config)
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    agt_cfg = agt_config::type_id::create("agt_cfg", this);
  endfunction
endclass: env_config

class environment extends uvm_env;
  env_config cfg;
  agent agt;

  `uvm_component_utils(environment)
  `comp_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(env_config)::get(this, "", "cfg", cfg);
    agt = agent::type_id::create("agt", this);
    uvm_config_db#(agt_config)::set(this, "agt", "cfg", cfg.agt_cfg);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("ENVIRONMENT", {"\n", this.sprint()}, UVM_MEDIUM);
  endfunction: start_of_simulation_phase
endclass: environment

class agt_config extends uvm_component;  // common work around for access to hierarchy
  rand comp_config seqr_cfg, drv_cfg, mon_cfg;
  `uvm_component_utils(agt_config)
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    seqr_cfg = comp_config::type_id::create("seqr_cfg", this);
    drv_cfg = comp_config::type_id::create("drv_cfg", this);
    mon_cfg = comp_config::type_id::create("mon_cfg", this);
  endfunction
endclass: agt_config

class agent extends uvm_agent;
  agt_config cfg;
  sequencer seqr;
  driver    drv;
  monitor   mon;

  `uvm_component_utils(agent)
  `comp_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(agt_config)::get(this, "", "cfg", cfg);
    seqr = sequencer::type_id::create("seqr", this);
    drv = driver::type_id::create("drv", this);
    mon = monitor::type_id::create("mon", this);
    uvm_config_db#(comp_config)::set(this, "seqr", "cfg", cfg.seqr_cfg);
    uvm_config_db#(comp_config)::set(this, "drv", "cfg", cfg.drv_cfg);
    uvm_config_db#(comp_config)::set(this, "mon", "cfg", cfg.mon_cfg);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("AGENT", {"\n", this.sprint()}, UVM_MEDIUM);
  endfunction: start_of_simulation_phase
endclass: agent

class comp_config extends uvm_component;  // common work around for access to hierarchy
  rand int unsigned timeout;
  rand bit[3:0] port_number;
  constraint valid{timeout inside {0,10,100,1000};}
  `uvm_component_utils_begin(comp_config)
    `uvm_field_int(timeout, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(port_number, UVM_ALL_ON | UVM_DEC)
  `uvm_component_utils_end
  `comp_new
endclass: comp_config

class sequencer extends uvm_component;
  comp_config cfg;

  `uvm_component_utils_begin(sequencer)
    `uvm_field_object(cfg, UVM_PRINT)
  `uvm_component_utils_end
  `comp_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(comp_config)::get(this, "", "cfg", cfg);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("SEQUENCER", {"\n", this.sprint()}, UVM_MEDIUM);
  endfunction: start_of_simulation_phase
endclass: sequencer

class driver extends uvm_component;
  comp_config cfg;

  `uvm_component_utils_begin(driver)
    `uvm_field_object(cfg, UVM_PRINT)
  `uvm_component_utils_end
  `comp_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(comp_config)::get(this, "", "cfg", cfg);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("DRIVER", {"\n", this.sprint()}, UVM_MEDIUM);
  endfunction: start_of_simulation_phase
endclass: driver 

class monitor extends uvm_component;
  comp_config cfg;

  `uvm_component_utils_begin(monitor)
    `uvm_field_object(cfg, UVM_PRINT)
  `uvm_component_utils_end
  `comp_new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(comp_config)::get(this, "", "cfg", cfg);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("MONITOR", {"\n", this.sprint()}, UVM_MEDIUM);
  endfunction: start_of_simulation_phase
endclass: monitor

`endif

