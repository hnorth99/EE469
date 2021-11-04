# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./regfile.sv"
vlog "./register64_32x.sv"
vlog "./register64.sv"
vlog "./eD_FF.sv"
vlog "./D_FF.sv"
vlog "./mux32_1_64x.sv"
vlog "./mux32_1.sv"
vlog "./mux16_1.sv"
vlog "./mux4_1.sv"
vlog "./mux2_1.sv"
vlog "./edecoder2_4.sv"
vlog "./edecoder3_8.sv"
vlog "./edecoder5_32.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work regfile_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do regfile_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
