`timescale 1ps/1ps
// This unit builds a singular dff for control logic in the regfileread pipeline stage.
// Recieves a clock and reset as well as all the required control logic from the decoder.
// Outputs values onto control logic name with O added to end
module datamem_queue_sub(clk, reset, ReadMem, MemWr, ReadMemO, MemWrO);
	input logic clk, reset;
	input logic ReadMem, MemWr;
	output logic ReadMemO, MemWrO;
	
	D_FF dffrd (.clk, .reset, .d(ReadMem), .q(ReadMemO));
	D_FF dffwr (.clk, .reset, .d(MemWr), .q(MemWrO));
endmodule

// Testbench to confirm unit is working correctly
module datamem_queue_sub_testbench();
	logic clk, reset;
	logic ReadMem, MemWr;
	logic ReadMemO, MemWrO;
	
	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	datamem_queue_sub dut (.*);
	
	initial begin
		reset <= 1'd0;	ReadMem <= 1'b0; MemWr <= 1'b0;													@(posedge clk);
		reset <= 1;																									@(posedge clk);
		reset <= 0; 																								@(posedge clk);
		
		ReadMem <= 1'b0; MemWr <= 1'b1;																		@(posedge clk);
		ReadMem <= 1'b1; MemWr <= 1'b0;																		@(posedge clk);							
		ReadMem <= 1'b1; MemWr <= 1'b1;																		@(posedge clk);
		ReadMem <= 1'b0; MemWr <= 1'b0;																		@(posedge clk);
		$stop;
	end
endmodule