# Makefile for SystemVerilog Class & Array handles lab
AFILES =  ./packet_types_pkg.sv types_pkg.sv top.sv

normal: clean sv_cmp
	vsim -c  top

gui: clean sv_cmp
	vsim  top 

sv_cmp:
	test -e work || vlib work
	vlog -suppress 2167 $(AFILES)

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

