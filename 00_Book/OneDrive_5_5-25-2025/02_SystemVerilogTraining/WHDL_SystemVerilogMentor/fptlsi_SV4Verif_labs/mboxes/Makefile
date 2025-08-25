# Makefile for SystemVerilog mboxes lab
AFILES =  ./types.sv  ./mbox.sv

normal: clean sv_cmp
	vsim -c  mbox

gui: clean sv_cmp
	vsim -voptargs=+acc mbox 

sv_cmp:
	test -e work || vlib work
	vlog $(AFILES)

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

