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
vlog   ./top.sv ./consumer.sv  ./link_if.sv  ./producer.sv
vsim -voptargs=+acc  top

# run simulation
#run -all

