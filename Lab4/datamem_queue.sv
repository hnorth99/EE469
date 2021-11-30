`timescale 1ps/1ps
// This unit builds the queue for control logic in the datamem pipeline stage.
// Recieves a clock and reset as well as all the required control logic from the decoder.
// Outputs values onto control logic name with O added to end
module datamem_queue(clk, reset, ReadMem, MemWr, ReadMemO, MemWrO);
	input logic clk, reset;
	input logic ReadMem, MemWr;
	output logic ReadMemO, MemWrO;
	
	logic r1, r2, w1, w2;
	datamem_queue_sub rm1 (.clk, .reset, .ReadMem, .MemWr, .ReadMemO(r1), .MemWrO(w1));
	datamem_queue_sub rm2 (.clk, .reset, .ReadMem(r1), .MemWr(w1), .ReadMemO(r2), .MemWrO(w2));
	datamem_queue_sub rm3 (.clk, .reset, .ReadMem(r2), .MemWr(w2), .ReadMemO, .MemWrO);
endmodule

// Testbench to confirm unit is working correctly
module datamem_queue_testbench();
	logic clk, reset;
	logic ReadMem, MemWr;
	logic ReadMemO, MemWrO;
	
	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	datamem_queue dut (.*);
	
	initial begin
		reset <= 1'd0;	ReadMem <= 1'b0; MemWr <= 1'b0;													@(posedge clk);
		reset <= 1;																									@(posedge clk);
		reset <= 0; 																								@(posedge clk);
		
		ReadMem <= 1'b0; MemWr <= 1'b1;																		@(posedge clk);
		ReadMem <= 1'b1; MemWr <= 1'b0;																		@(posedge clk);							
		ReadMem <= 1'b1; MemWr <= 1'b1;																		@(posedge clk);
		ReadMem <= 1'b0; MemWr <= 1'b0;															repeat(4)@(posedge clk);
		$stop;
	end
endmodule