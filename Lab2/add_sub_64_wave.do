onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /add_sub_64_testbench/a
add wave -noupdate -radix decimal /add_sub_64_testbench/b
add wave -noupdate -radix decimal /add_sub_64_testbench/sub
add wave -noupdate -radix decimal /add_sub_64_testbench/s
add wave -noupdate -radix decimal /add_sub_64_testbench/overflow
add wave -noupdate /add_sub_64_testbench/carryout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {39582 ps} 0}
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
WaveRestoreZoom {20100 ps} {62100 ps}
