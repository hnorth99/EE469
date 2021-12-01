`timescale 1ps/1ps
// This unit builds an alu_queue out of 2 alu_queue_sub.
// Recieves a clock and reset to coordinate operation within unit.
// Additionally takes a 3 bit input (ALUCntrl) and 1 bit input (FlagE) 
// that will be loaded into the register.
// Output of the register is projected onto ALUCntrlO and FlagEO.
// Takes 2 clock cycles to pass the data.
module alu_queue (clk, reset, ALUCntrl, FlagE, ALUCntrlO, FlagEO);
	input logic clk, reset, FlagE;
	input logic [2:0] ALUCntrl;
	output logic [2:0] ALUCntrlO;
	output logic FlagEO;
	
	logic [2:0] ALUCntrl_int;
	logic FlagE_int;
	
	alu_queue_sub aluq1 (.clk, .reset, .ALUCntrl, .FlagE, .ALUCntrlO(ALUCntrl_int), .FlagEO(FlagE_int));
	alu_queue_sub aluq2 (.clk, .reset, .ALUCntrl(ALUCntrl_int), .FlagE(FlagE_int), .ALUCntrlO, .FlagEO);
	

endmodule

module alu_queue_testbench();
	logic clk, reset, FlagE, FlagEO;
	logic [2:0] ALUCntrl, ALUCntrlO;

	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	alu_queue dut (.*);
	
	initial begin
		reset <= 0; ALUCntrl <= 3'd0; FlagE <= 1'd0;		@(posedge clk);
		reset <= 1; 												@(posedge clk);
		reset <= 0; 												@(posedge clk);
		ALUCntrl <= 3'd3; FlagE <= 1'd0;		repeat(3)@(posedge clk);
		ALUCntrl <= 3'd5; FlagE <= 1'd1;		repeat(3)@(posedge clk);
		
		$stop;
	end 
endmodule