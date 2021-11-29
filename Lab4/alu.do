# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./alu.sv"
vlog "./full_adder.sv"
vlog "./add_sub.sv"
vlog "./add_sub_64.sv"
vlog "./mux8_1.sv"
vlog "./mux4_1.sv"
vlog "./mux2_1.sv"
vlog "./mux8_1_64x.sv"
vlog "./bitwise_and_64.sv"
vlog "./bitwise_or_64.sv"
vlog "./bitwise_xor_64.sv"
vlog "./nor_64.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work alu_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do alu_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
