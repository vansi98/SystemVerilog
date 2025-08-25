# WHDL SystemVerilog for Verification Course
#  - Setup & simulation script for

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
vlog  ./packet_types_pkg.sv types_pkg.sv top.sv
vsim -voptargs=+acc top

# run simulation
#run -all

