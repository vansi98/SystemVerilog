#Makefile for sva_intro lab

SOURCES = sva_ex.sv

normal: clean compile
	vsim -assertdebug sva_ex

compile:
	test -e work || vlib work
	vlog +acc=a $(SOURCES)

test:   clean compile
	vsim -c -assertdebug sva_ex  -do "run -all; quit"     

clean:
	@echo "Cleaning up files..."
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb


