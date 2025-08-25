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
vlog  +define+TRACE_ON=0 ./defs.sv ./top.sv ./router_if.sv ./test_router.sv ./router_assertions.sv ./router.sv
vsim -voptargs=+acc -assertdebug top

# run simulation
run -all

