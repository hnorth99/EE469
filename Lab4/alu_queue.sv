`timescale 1ps/1ps
// This unit builds an alu_queue out of 2 alu_queue_sub.
// Recieves a clock and reset to coordinate operation within unit.
// Additionally takes a 3 bit input (ALUCntrl) and 1 bit input (FlagE) 
// that will be loaded into the register.
// Output of the register is projected onto ALUCntrlO and FlagEO.
// Takes 2 clock cycles to pass the data.
module alu_queue (clk, reset, ALUCntrl, FlagE, FwdALU, ShiftDir, ShiftToALUB, Shamt, 
							 ALUCntrlO, FlagEO, FwdALUO, ShiftDirO, ShiftToALUBO, ShamtO);
	input logic clk, reset, FlagE, FwdALU;
	input logic ShiftDir, ShiftToALUB;
	input logic [5:0] Shamt;
	input logic [2:0] ALUCntrl;
	output logic [2:0] ALUCntrlO;
	output logic ShiftDirO, ShiftToALUBO;
	output logic [5:0] ShamtO;
	output logic FlagEO, FwdALUO;
	
	logic [2:0] ALUCntrl_int;
	logic [5:0] Shamt_int;
	logic FlagE_int, FwdALU_int, ShiftDir_int, ShiftToALUB_int;
	
	alu_queue_sub aluq1 (.clk, .reset, .ALUCntrl, .FlagE, .FwdALU, .ShiftDir, .ShiftToALUB, .Shamt,
								.ALUCntrlO(ALUCntrl_int), .FlagEO(FlagE_int), .FwdALUO(FwdALU_int),
								.ShiftDirO(ShiftDir_int), .ShiftToALUBO(ShiftToALUB_int), .ShamtO(Shamt_int));
	alu_queue_sub aluq2 (.clk, .reset, .ALUCntrl(ALUCntrl_int), .ShiftDir(ShiftDir_int), .ShiftToALUB(ShiftToALUB_int),
								.Shamt(Shamt_int),
								.FlagE(FlagE_int), .FwdALU(FwdALU_int), .ALUCntrlO, .FlagEO, .FwdALUO, .ShiftDirO, 
								.ShiftToALUBO, .ShamtO);

endmodule

module alu_queue_testbench();
	logic clk, reset, FlagE, FlagEO, FwdALU, FwdALUO;
	logic [2:0] ALUCntrl, ALUCntrlO;
	logic [5:0] Shamt, ShamtO;
	logic ShiftDir, ShiftToALUB, ShiftDirO, ShiftToALUBO;
	
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
		ALUCntrl <= 3'd3; FlagE <= 1'd0;			repeat(3)@(posedge clk);
		ALUCntrl <= 3'd5;FlagE <= 1'd1;			repeat(3)@(posedge clk);
		
		$stop;
	end 
endmodule