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
vlog  types_pkg.sv test_sm.sv beh_sram.v  sm_func.v sm_seq.v  sm.sv sva_container.sv
vsim -voptargs=+acc -assertdebug test_sm

# run simulation
#run -all
