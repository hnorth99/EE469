# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

vlog "./forwarding_unit.sv"
vlog "./instruction_handler.sv"
vlog "./instruction_decoder.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./math.sv"
vlog "./alu_queue.sv"
vlog "./datamem_queue.sv"
vlog "./datamem_queue_sub.sv"
vlog "./regfilewrite_queue.sv"
vlog "./regfileread_queue.sv"
vlog "./alu_queue_sub.sv"
vlog "./regfilewrite_queue_sub.sv"
vlog "./register5_3x.sv"
vlog "./register5.sv"
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
