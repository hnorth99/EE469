onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /flag_handler_testbench/dut/clk
add wave -noupdate /flag_handler_testbench/dut/reset
add wave -noupdate /flag_handler_testbench/dut/en
add wave -noupdate /flag_handler_testbench/dut/zero_in
add wave -noupdate /flag_handler_testbench/dut/cout_in
add wave -noupdate /flag_handler_testbench/dut/neg_in
add wave -noupdate /flag_handler_testbench/dut/oflow_in
add wave -noupdate /flag_handler_testbench/dut/negative
add wave -noupdate /flag_handler_testbench/dut/overflow
add wave -noupdate /flag_handler_testbench/dut/zero
add wave -noupdate /flag_handler_testbench/dut/carry_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
