onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regfilewrite_queue_sub_testbench/reset
add wave -noupdate /regfilewrite_queue_sub_testbench/clk
add wave -noupdate -radix unsigned /regfilewrite_queue_sub_testbench/Rd
add wave -noupdate -radix unsigned /regfilewrite_queue_sub_testbench/RdO
add wave -noupdate -radix unsigned /regfilewrite_queue_sub_testbench/RegWData
add wave -noupdate -radix unsigned /regfilewrite_queue_sub_testbench/RegWDataO
add wave -noupdate /regfilewrite_queue_sub_testbench/RegWrt
add wave -noupdate /regfilewrite_queue_sub_testbench/RegWrtO
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
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
