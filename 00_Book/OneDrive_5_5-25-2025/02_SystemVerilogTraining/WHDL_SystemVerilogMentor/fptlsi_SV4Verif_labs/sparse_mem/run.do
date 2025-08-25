# WHDL SystemVerilog for Verification Course
#  - Setup & simulation script for
#  Sparse Memory Lab

onbreak {resume}
onerror {quit -f}

if [file exists work] {
    vdel -all
}
vlib work

echo "#"
echo "# NOTE: Starting simulator and running DEMO ..."
echo "#"

# compile & run first simulation
vlog   ./sparse_mem.sv
vsim -voptargs=+acc -assertdebug sparse_mem

# run simulation
#run -all

