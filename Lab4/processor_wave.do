onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_testbench/clk
add wave -noupdate /processor_testbench/reset
add wave -noupdate -radix unsigned /processor_testbench/dut/wdata
add wave -noupdate /processor_testbench/dut/zflag
add wave -noupdate /processor_testbench/dut/oflag
add wave -noupdate /processor_testbench/dut/nflag
add wave -noupdate /processor_testbench/dut/cflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31043 ps} 0}
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
WaveRestoreZoom {0 ps} {89250 ps}
