onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux4_1_64x_testbench/i
add wave -noupdate /mux4_1_64x_testbench/i00
add wave -noupdate /mux4_1_64x_testbench/i01
add wave -noupdate /mux4_1_64x_testbench/i10
add wave -noupdate /mux4_1_64x_testbench/i11
add wave -noupdate /mux4_1_64x_testbench/out
add wave -noupdate /mux4_1_64x_testbench/sel0
add wave -noupdate /mux4_1_64x_testbench/sel1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {68 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {648 ps}
