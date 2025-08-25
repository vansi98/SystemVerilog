# Makefile for SystemVerilog router oop lab
RTL= ./router.sv
BADRTL= ../.bad_rtl/router.sv
SVTB = ./defs.sv ./top.sv ./router_if.sv ./test_router.sv ./router_assertions.sv

normal: clean sv_lib
	qverilog +acc=a $(SVTB) $(RTL) +define+TRACE_ON=0 

bad: clean sv_cmp_bad 
	vsim -assertdebug top -do router_wave.do

run: clean sv_cmp
	vsim -c -assertdebug top

gui: clean sv_cmp
	vsim -assertdebug -voptargs=+acc top -do router_wave.do

sv_cmp: sv_lib
	vlog +acc=a $(SVTB) $(RTL) +define+TRACE_ON=0 

sv_lib:
	test -e work || vlib work

sv_cmp_bad:
	test -e work || vlib work
	vlog +acc=a $(BADRTL) $(SVTB) +define+TRACE_ON=0

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

