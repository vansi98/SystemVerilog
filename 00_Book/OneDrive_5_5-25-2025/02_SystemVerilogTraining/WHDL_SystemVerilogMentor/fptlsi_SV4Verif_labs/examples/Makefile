# Makefile for SystemVerilog Class & Array handles lab
AFILES =  ./array_handles.sv

normal: clean sv_cmp
	vsim -c  array_handles

gui: clean sv_cmp
	vsim  array_handles 

sv_cmp:
	test -e work || vlib work
	vlog $(AFILES)

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

