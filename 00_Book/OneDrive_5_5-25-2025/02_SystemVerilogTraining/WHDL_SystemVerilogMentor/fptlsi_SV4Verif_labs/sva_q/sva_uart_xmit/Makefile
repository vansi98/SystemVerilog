#Makefile for sva_uart lab

SOURCES = test_u_xmit.sv  u_xmit.sv

BAD = 

normal: clean sv_cmp
	vsim -c -assertdebug test_u_xmit

gui: clean sv_cmp
	vsim  -assertdebug -voptargs=+acc test_u_xmit 

sv_cmp:
	test -e work || vlib work
	vlog +acc=a $(SOURCES)

bad:
	test -e work || vlib work
	vlog +acc=a $(BAD)
	vsim  -assertdebug -voptargs=+acc test_u_xmit 

run:
	vsim -c -assertdebug test_u_xmit

compile_bad:
	vlog +acc=a $(BAD)

	
clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

