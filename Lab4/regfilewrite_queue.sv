`timescale 1ps/1ps
// This unit builds a regfilewrite_queue out of 4 regfilewrite_queue_sub.
// Recieves a clock and reset to coordinate operation within unit.
// Additionally takes a 1 bit input (RegWrt), 2 bit input (RegWData), and 5 bit input (Rd)
// that will be loaded into the register.
// Output of the register is projected onto RegWrtO, RegWDataO, and RdO.
// Takes 4 clock cycles.
module regfilewrite_queue (clk, reset, RegWrt, RegWData, Rd, RegWrtO, RegWDataO, RdO);
	input logic clk, reset, RegWrt;
	input logic [1:0] RegWData;
	input logic [4:0] Rd;
	output logic RegWrtO;
	output logic [1:0] RegWDataO;
	output logic [4:0] RdO;
	
	logic RW1, RW2, RW3;
	logic [1:0] RWD1, RWD2, RWD3;
	logic [4:0] Rd1, Rd2, Rd3;
	
	regfilewrite_queue_sub r1 (.clk, .reset, .RegWrt, .RegWData, .Rd, .RegWrtO(RW1), .RegWDataO(RWD1), .RdO(Rd1));
	regfilewrite_queue_sub r2 (.clk, .reset, .RegWrt(RW1), .RegWData(RWD1), .Rd(Rd1), .RegWrtO(RW2), .RegWDataO(RWD2), .RdO(Rd2));
	regfilewrite_queue_sub r3 (.clk, .reset, .RegWrt(RW2), .RegWData(RWD2), .Rd(Rd2), .RegWrtO(RW3), .RegWDataO(RWD3), .RdO(Rd3));
	regfilewrite_queue_sub r4 (.clk, .reset, .RegWrt(RW3), .RegWData(RWD3), .Rd(Rd3), .RegWrtO, .RegWDataO, .RdO);

endmodule

module regfilewrite_queue_testbench();
	logic clk, reset, RegWrt;
	logic [1:0] RegWData;
	logic [4:0] Rd;
	logic RegWrtO;
	logic [1:0] RegWDataO;
	logic [4:0] RdO;

	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	regfilewrite_queue dut (.*);
	
	initial begin
		reset <= 0; RegWrt <= 1'd0; RegWData <= 2'd0; Rd <= 5'd0;		@(posedge clk);
		reset <= 1; 																	@(posedge clk);
		reset <= 0; 																	@(posedge clk);
		RegWrt <= 1'd1; RegWData <= 2'd0; Rd <= 5'd0;			repeat(6)@(posedge clk); // RegWrtO gets a 1
		RegWrt <= 1'd1; RegWData <= 2'd3; Rd <= 5'd0;			repeat(6)@(posedge clk); // RegWDataO gets a 3
		RegWrt <= 1'd1; RegWData <= 2'd3; Rd <= 5'd12;			repeat(6)@(posedge clk); // RdO gets a 12
		
		$stop;
	end 
endmodule