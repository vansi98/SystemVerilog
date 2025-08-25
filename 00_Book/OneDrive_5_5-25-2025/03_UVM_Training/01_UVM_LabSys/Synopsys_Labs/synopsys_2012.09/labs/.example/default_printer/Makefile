TB_TOP = ./test.sv
test = test_base
verbosity = UVM_MEDIUM
uvm_ver = uvm-1.1
seed = 1
defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
plus = 
option = 
#option = UVM_OBJECTION_TRACE
SOLVER = 2

all: simv run

simv compile: *.sv
	vcs -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson $(DUT) $(HARNESS_TOP) $(TB_TOP) +define+${defines}

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

random: simv
	./simv -l simv.log +ntb_random_seed_automatic +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

dve_i: simv
	./simv -l simv.log -gui +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *~

