onerror {resume}
quietly virtual function -install /mux32_1_testbench -env /mux32_1_testbench { &{/mux32_1_testbench/sel0, /mux32_1_testbench/sel1, /mux32_1_testbench/sel2, /mux32_1_testbench/sel3, /mux32_1_testbench/sel4 }} select
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux32_1_testbench/i0
add wave -noupdate /mux32_1_testbench/i1
add wave -noupdate /mux32_1_testbench/i2
add wave -noupdate /mux32_1_testbench/i3
add wave -noupdate /mux32_1_testbench/i4
add wave -noupdate /mux32_1_testbench/i5
add wave -noupdate /mux32_1_testbench/i6
add wave -noupdate /mux32_1_testbench/i7
add wave -noupdate /mux32_1_testbench/i8
add wave -noupdate /mux32_1_testbench/i9
add wave -noupdate /mux32_1_testbench/i10
add wave -noupdate /mux32_1_testbench/i11
add wave -noupdate /mux32_1_testbench/i12
add wave -noupdate /mux32_1_testbench/i13
add wave -noupdate /mux32_1_testbench/i14
add wave -noupdate /mux32_1_testbench/i15
add wave -noupdate /mux32_1_testbench/i16
add wave -noupdate /mux32_1_testbench/i17
add wave -noupdate /mux32_1_testbench/i18
add wave -noupdate /mux32_1_testbench/i19
add wave -noupdate /mux32_1_testbench/i20
add wave -noupdate /mux32_1_testbench/i21
add wave -noupdate /mux32_1_testbench/i22
add wave -noupdate /mux32_1_testbench/i23
add wave -noupdate /mux32_1_testbench/i24
add wave -noupdate /mux32_1_testbench/i25
add wave -noupdate /mux32_1_testbench/i26
add wave -noupdate /mux32_1_testbench/i27
add wave -noupdate /mux32_1_testbench/i28
add wave -noupdate /mux32_1_testbench/i29
add wave -noupdate /mux32_1_testbench/i30
add wave -noupdate /mux32_1_testbench/i31
add wave -noupdate -radix unsigned /mux32_1_testbench/select
add wave -noupdate /mux32_1_testbench/sel0
add wave -noupdate /mux32_1_testbench/sel1
add wave -noupdate /mux32_1_testbench/sel2
add wave -noupdate /mux32_1_testbench/sel3
add wave -noupdate /mux32_1_testbench/sel4
add wave -noupdate /mux32_1_testbench/out
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
WaveRestoreZoom {0 ps} {988 ps}
