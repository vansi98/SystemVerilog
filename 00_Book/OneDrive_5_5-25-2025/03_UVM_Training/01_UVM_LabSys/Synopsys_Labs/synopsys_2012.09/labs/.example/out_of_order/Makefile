# Makefile for UVM Lab1
rtl_path = ../../rtl
TB_TOP = ./test.sv
UVM_HOME = ../../uvm-1.1a
test = test_base
verbosity = UVM_MEDIUM
uvm_ver = uvm-1.1
seed = 1
defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
defines_record = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR+UVM_DISABLE_AUTO_ITEM_RECORDING
option = UVM_TR_RECORD +UVM_LOG_RECORD
plus = 
#option = UVM_OBJECTION_TRACE
SOLVER = 2

all:
	vcs -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson $(DUT) $(HARNESS_TOP) $(TB_TOP) +define+${defines}
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

record:
	vcs -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson $(DUT) $(HARNESS_TOP) $(TB_TOP) +define+${defines_record}
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

random:
	./simv -l simv.log +ntb_random_seed_automatic +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus}

dve:
	dve -vpd vcdplus.vpd

dve_i:
	./simv -l simv.log -gui +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus}

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *~
