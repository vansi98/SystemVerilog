#Makefile for sva_pipe lab

SOURCES =   ./test_pipe.sv ./pipe.sv
BAD = ./test_pipe.sv ./bad_pipe.sv 

normal: clean sv_cmp
	vsim -c -assertdebug test_pipe

gui: clean sv_cmp
	vsim  -assertdebug -voptargs=+acc test_pipe 

sv_cmp:
	test -e work || vlib work
	vlog +acc=a $(SOURCES)

bad:
	test -e work || vlib work
	vlog +acc=a $(BAD)
	vsim  -assertdebug -voptargs=+acc test_pipe 

run:
	vsim -c -assertdebug -voptargs=+acc test_pipe

compile_bad:
	vlog +acc=a $(BAD)

	
clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

