# WHDL SystemVerilog for Verification Course
#  - Setup & simulation script for
#  Router complete

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
vlog   ./types.sv ./mbox.sv
vsim -voptargs=+acc -assertdebug mbox

# run simulation
#run -all

