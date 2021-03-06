# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

vlog "./instruction_handler.sv"
vlog "./instruction_decoder.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./math.sv"
vlog "./processor.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work processor_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do runlab_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
