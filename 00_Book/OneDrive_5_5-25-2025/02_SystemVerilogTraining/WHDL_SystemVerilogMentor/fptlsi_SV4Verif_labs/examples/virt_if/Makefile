# Makefile for SystemVerilog Class & Array handles lab
AFILES =  ./types.sv ./dut_if.sv ./dut.sv ./top.sv 

normal: clean sv_cmp
	vsim -c  top

gui: clean sv_cmp
	vsim  top 

sv_cmp:
	test -e work || vlib work
	vlog $(AFILES)

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

