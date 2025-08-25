# WHDL SystemVerilog for Verification Course
#  - Setup & simulation script for
#  Car Case Lab

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
vlog   ../test_car_case.v ./car_case.v
vsim -voptargs=+acc -assertdebug test_car_case

# run simulation
#run -all

