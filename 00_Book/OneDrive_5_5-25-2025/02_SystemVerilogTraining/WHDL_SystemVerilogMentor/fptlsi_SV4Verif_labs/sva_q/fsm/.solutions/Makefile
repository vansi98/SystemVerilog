#Makefile for sva_pipe lab

SOURCES = types_pkg.sv test_sm.sv beh_sram.v  sm_func.v sm_seq.v  sm.sv sva_container.sv
BAD = types_pkg.sv test_sm.sv beh_sram.v  sm_func.v sm_seq.v  bad_sm.sv sva_container.sv

normal: clean sv_cmp
	vsim -c -assertdebug test_sm

gui: clean sv_cmp
	vsim  -assertdebug test_sm 

sv_cmp:
	test -e work || vlib work
	vlog +acc=a $(SOURCES)

bad:
	test -e work || vlib work
	vlog +acc=a $(BAD)
	vsim  -assertdebug test_sm 

run:
	vsim -c -assertdebug test_sm

compile_bad:
	vlog +acc=a $(BAD)

	
clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

