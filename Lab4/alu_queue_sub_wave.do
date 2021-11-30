onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_queue_sub_testbench/reset
add wave -noupdate /alu_queue_sub_testbench/clk
add wave -noupdate -radix unsigned /alu_queue_sub_testbench/ALUCntrl
add wave -noupdate -radix unsigned /alu_queue_sub_testbench/ALUCntrlO
add wave -noupdate /alu_queue_sub_testbench/FlagE
add wave -noupdate /alu_queue_sub_testbench/FlagEO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {211 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {869 ps}
