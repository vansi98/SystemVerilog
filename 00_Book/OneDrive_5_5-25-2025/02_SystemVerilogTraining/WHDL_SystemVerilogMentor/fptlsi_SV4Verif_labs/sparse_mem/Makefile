# Makefile for SystemVerilog sparse_meme lab
AFILES =  ./sparse_mem.sv

normal: clean sv_cmp
	vsim -c  sparse_mem

gui: clean sv_cmp
	vsim -voptargs=+acc sparse_mem 

sv_cmp:
	test -e work || vlib work
	vlog $(AFILES)

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

