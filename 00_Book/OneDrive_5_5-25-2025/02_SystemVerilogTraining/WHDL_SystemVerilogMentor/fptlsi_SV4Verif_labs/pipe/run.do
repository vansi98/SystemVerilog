# WHDL SystemVerilog for Verification Course
#  - Setup & simulation script for
#  Pipe Lab

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
vlog   ./test_pipe.v ./pipe.v
vsim -voptargs=+acc -assertdebug test_pipe

# run simulation
#run -all

