`timescale 1ns/10ps
// This unit builds the queue for control logic in the regfileread pipeline stage.
// Recieves a clock and reset as well as all the required control logic from the decoder.
// Outputs values onto control logic name with O added to end
module regfileread_queue(clk, reset, Swap, RdToRdA, RdToRdB, Shamt, ShiftDir,
								 ShiftToALUB, Imm12ALU, ImmALUA, ImmALUA, Imm12, Imm9,
								 SwapO, RdToRdAO, RdToRdBO, ShamtO, ShiftDirO,
								 ShiftToALUBO, Imm12ALUO, ImmALUAO, Imm12O, Imm9O);
	input logic clk, reset, Swap, RdToRdA, RdToRdB, ShiftDir, 
					ShiftToALUB, Imm12ALU, ImmALUA;
	input logic [5:0] Shamt;
	input logic [11:0] Imm12;
	input logic [8:0] Imm9;
	
	output logic SwapO, RdToRdAO, RdToRdBO, ShiftDirO,
					ShiftToALUBO, Imm12ALUO, ImmALUAO;
	output logic [5:0] ShamtO;
	output logic [11:0] Imm12O;
	output logic [8:0] Imm9O;
	
	// 1 bit dffs
	D_FF dffSwap (.clk, .reset, .d(Swap), .q(SwapO));
	D_FF dffRdToRdA (.clk, .reset, .d(RdToRdA), .q(RdToRdAO));
	D_FF dffRdToRdB (.clk, .reset, .d(RdToRdB), .q(RdToRdBO));
	D_FF dffShiftDir (.clk, .reset, .d(ShiftDir), .q(ShiftDirO));
	D_FF dffShiftToALUB (.clk, .reset, .d(ShiftToALUB), .q(ShiftToALUBO));
	D_FF dffImm12ALU (.clk, .reset, .d(Imm12ALU), .q(Imm12ALUO));
	D_FF dffImmALUA (.clk, .reset, .d(ImmALUA), .q(ImmALUAO));
	
	// 6 bit dff
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : eachBit0
			D_FF ds (.q(ShamtO[i]), .d(Shamt[i]), .reset, .clk);
		end
	endgenerate
	
	// 9 bit dff
	generate
		for (i = 0; i < 64; i++) begin : eachBit1
			D_FF d9 (.q(Imm9O[i]), .d(Imm9[i]), .reset, .clk);
		end
	endgenerate
	
	// 12 bit dff
	generate
		for (i = 0; i < 64; i++) begin : eachBit2
			D_FF d12 (.q(Imm12O[i]), .d(Imm12[i]), .reset, .clk);
		end
	endgenerate
	
endmodule

// Testbench to confirm unit is working correctly
module regfileread_queue_testbench();

	logic clk, reset, Swap, RdToRdA, RdToRdB, ShiftDir, 
					ShiftToALUB, Imm12ALU, ImmALUA;
	logic [5:0] Shamt;
	logic [11:0] Imm12;
	logic [8:0] Imm9;
	
	logic SwapO, RdToRdAO, RdToRdBO, ShiftDirO,
					ShiftToALUBO, Imm12ALUO, ImmALUAO;
	logic [5:0] ShamtO;
	logic [11:0] Imm12O;
	logic [8:0] Imm9O;

	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	regfileread_queue dut (.*);
	
	initial begin
		reset <= 1'd0;	Swap <= 1'd0; RdToRdA <= 1'd0; RdToRdB <= 1'd0; ShiftDir <= 1'd0; 
		ShiftToALUB <= 1'd0; Imm12ALU <= 1'd0; ImmALUA <= 1'd0;	Shamt <= 6'd0;								
		Imm9 <= 9'd0; Imm12 <= 12'd0;																			@(posedge clk);
		reset <= 1;																									@(posedge clk);
		reset <= 0; 																								@(posedge clk);
		
		Swap <= 1'd1; RdToRdA <= 1'd0; RdToRdB <= 1'd1; ShiftDir <= 1'd0; 
		ShiftToALUB <= 1'd1; Imm12ALU <= 1'd0; ImmALUA <= 1'd1;	Shamt <= 6'd10;								
		Imm9 <= 9'd15; Imm12 <= 12'd20;																		@(posedge clk);
		
		Swap <= 1'd0; RdToRdA <= 1'd1; RdToRdB <= 1'd0; ShiftDir <= 1'd1; 
		ShiftToALUB <= 1'd0; Imm12ALU <= 1'd1; ImmALUA <= 1'd0;	Shamt <= 6'd15;								
		Imm9 <= 9'd20; Imm12 <= 12'd25;																		@(posedge clk);
		
		Swap <= 1'd1; RdToRdA <= 1'd0; RdToRdB <= 1'd1; ShiftDir <= 1'd0; 
		ShiftToALUB <= 1'd1; Imm12ALU <= 1'd0; ImmALUA <= 1'd1;	Shamt <= 6'd20;								
		Imm9 <= 9'd25; Imm12 <= 12'd30;																		@(posedge clk);
		
		$stop;
	end
endmodule
