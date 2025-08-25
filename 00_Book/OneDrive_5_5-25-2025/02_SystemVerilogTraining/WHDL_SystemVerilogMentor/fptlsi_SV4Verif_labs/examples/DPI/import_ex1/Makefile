# Makefile for DPI examples
# NOTE - set QUESTA_HOME to point to the questasim install dir
# QUESTA_HOME /home/tools/questasim

AFILES =  ./array_handles.sv

ifndef QUESTA_HOME
  $(error The QUESTA_HOME environment variable is not set)
endif

normal: clean hdr_cmp cc_cmp sv_cmp
	vsim -c -sv_lib my_lib import_ex1
        

hdr_cmp:
	test -e work || vlib work
	vlog -dpiheader dpiheader.h import_ex1.sv

cc_cmp: 
	gcc -I$(QUESTA_HOME)/include -shared -g -o my_lib.so my_lib.c 

sv_cmp:
	vlog import_ex1.sv

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb *.so
