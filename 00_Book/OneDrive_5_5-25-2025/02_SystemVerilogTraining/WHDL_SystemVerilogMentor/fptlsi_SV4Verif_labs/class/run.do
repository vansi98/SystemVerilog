# WHDL SystemVerilog for Verification Course
#  - Setup & simulation script for
#  Array Handles (Class) Lab

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
vlog   ./array_handles.sv
vsim -voptargs=+acc -assertdebug array_handles

# run simulation
#run -all

