onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regfileread_queue_testbench/clk
add wave -noupdate /regfileread_queue_testbench/reset
add wave -noupdate /regfileread_queue_testbench/Swap
add wave -noupdate /regfileread_queue_testbench/SwapO
add wave -noupdate /regfileread_queue_testbench/RdToRdA
add wave -noupdate /regfileread_queue_testbench/RdToRdAO
add wave -noupdate /regfileread_queue_testbench/RdToRdB
add wave -noupdate /regfileread_queue_testbench/RdToRdBO
add wave -noupdate /regfileread_queue_testbench/ShiftDir
add wave -noupdate /regfileread_queue_testbench/ShiftDirO
add wave -noupdate /regfileread_queue_testbench/ShiftToALUB
add wave -noupdate /regfileread_queue_testbench/ShiftToALUBO
add wave -noupdate /regfileread_queue_testbench/Imm12ALU
add wave -noupdate /regfileread_queue_testbench/Imm12ALUO
add wave -noupdate /regfileread_queue_testbench/ImmALUA
add wave -noupdate /regfileread_queue_testbench/ImmALUAO
add wave -noupdate -radix unsigned /regfileread_queue_testbench/Shamt
add wave -noupdate -radix unsigned /regfileread_queue_testbench/ShamtO
add wave -noupdate -radix unsigned /regfileread_queue_testbench/Imm9
add wave -noupdate -radix unsigned /regfileread_queue_testbench/Imm9O
add wave -noupdate -radix unsigned /regfileread_queue_testbench/Imm12
add wave -noupdate -radix unsigned /regfileread_queue_testbench/Imm12O
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {74437 ps} 0}
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
WaveRestoreZoom {0 ps} {577500 ps}
