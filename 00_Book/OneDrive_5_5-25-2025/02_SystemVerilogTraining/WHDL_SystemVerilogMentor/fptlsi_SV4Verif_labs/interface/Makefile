# Makefile for SystemVerilog Producer/Consumer lab
PCFILES =  ./top.sv ./consumer.sv  ./link_if.sv  ./producer.sv

normal: clean sv_cmp
	vsim -c  top

gui: clean sv_cmp
	vsim -voptargs=+acc top 

sv_cmp:
	test -e work || vlib work
	vlog $(PCFILES)

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb

