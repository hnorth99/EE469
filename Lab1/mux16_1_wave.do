onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux16_1_testbench/i0
add wave -noupdate /mux16_1_testbench/i2
add wave -noupdate /mux16_1_testbench/i5
add wave -noupdate /mux16_1_testbench/i7
add wave -noupdate /mux16_1_testbench/i8
add wave -noupdate /mux16_1_testbench/i10
add wave -noupdate /mux16_1_testbench/i13
add wave -noupdate /mux16_1_testbench/i15
add wave -noupdate /mux16_1_testbench/sel3
add wave -noupdate /mux16_1_testbench/sel2
add wave -noupdate /mux16_1_testbench/sel1
add wave -noupdate /mux16_1_testbench/sel0
add wave -noupdate /mux16_1_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {179 ps}
