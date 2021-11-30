`timescale 1ps/1ps
// This unit builds a register out of 4 individual D_FFs.
// Recieves a clock and reset to coordinate operation within unit.
// Additionally takes a 3 bit input (ALUCntrl) and 1 bit input (FlagE) 
// that will be loaded into the register.
// Output of the register is projected onto ALUCntrlO and FlagEO.
module alu_queue_sub (clk, reset, ALUCntrl, FlagE, ALUCntrlO, FlagEO);
	input logic clk, reset, FlagE;
	input logic [2:0] ALUCntrl;
	output logic [2:0] ALUCntrlO;
	output logic FlagEO;
	
	genvar i;
	generate
		for (i = 0; i < 3; i++) begin : eachBit
			D_FF alu (.clk, .reset, .d(ALUCntrl[i]), .q(ALUCntrlO[i]));
		end
	endgenerate
	
	D_FF flag (.clk, .reset, .d(FlagE), .q(FlagEO));

endmodule

module alu_queue_sub_testbench();
	logic clk, reset, FlagE, FlagEO;
	logic [2:0] ALUCntrl, ALUCntrlO;

	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	alu_queue_sub dut (.*);
	
	initial begin
		reset <= 0; ALUCntrl <= 3'd0; FlagE <= 1'd0;		@(posedge clk);
		reset <= 1; 												@(posedge clk);
		reset <= 0; 												@(posedge clk);
		ALUCntrl <= 3'd3; FlagE <= 1'd0;		repeat(2)@(posedge clk);
		ALUCntrl <= 3'd5; FlagE <= 1'd1;		repeat(2)@(posedge clk);
		
		$stop;
	end 
endmodule