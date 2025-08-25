# Makefile for SystemVerilog router oop lab
RTL= ./router.sv
BADRTL= ../.bad_rtl/router.sv
SVTB = ./defs.sv ./top.sv ./router_if.sv ./test_router.sv ./router_assertions.sv

normal: clean sv_cmp
	vsim -c -assertdebug top

bad: clean sv_cmp_bad 
	vsim -assertdebug top -do router_wave.do

gui: clean sv_cmp
	vsim -assertdebug -voptargs=+acc top -do router_wave.do

sv_cmp:
	test -e work || vlib work
	vlog +acc=a $(SVTB) $(RTL) +define+TRACE_ON=0 

sv_cmp_bad:
	test -e work || vlib work
	vlog +acc=a $(BADRTL) $(SVTB) +define+TRACE_ON=0

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

