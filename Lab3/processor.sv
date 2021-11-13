// Single cycle processor used to run the arm instructions
// provided in canvas.
`timescale 1ps/1ps
module processor(clk, reset);
	input logic clk, reset;
	
	logic LT, ALU_Zero, UncondBr, BrTaken, ImmALUA, RegWrite;
	logic RdToRdB, Imm12ALU, ShiftToALUB, ShiftDir;
	logic ReadMem, MemWr, RdToRdA, FlagE, swap;
	logic [02:0] ALUCntrl;
	logic [01:0] RegWData;
	logic [04:0] rd, rm, rn;
	logic [05:0] shamt;
	logic [31:0] instruction;
	logic [25:0] imm26;
	logic [18:0] imm19;
	logic [11:0] imm12;
	logic [08:0] imm9;
	
	instruction_handler ih (.clk, .reset, .imm26, .imm19, .uncondBr(UncondBr), .brTaken(BrTaken), .instr(instruction));

	instruction_decoder id (.instruction, .LT, .ALU_Zero,
									.UncondBr, .BrTaken, .ImmALUA, .RegWrite, 
									.RdToRdB, .Imm12ALU, .RegWData, .ShiftToALUB, .ShiftDir,
									.ReadMem, .MemWr, .RdToRdA, .ALUCntrl, .FlagE,
									.rd, .rm, .rn, .imm26, .imm19, .imm12, .imm9,
									.shamt, .swap);
									
	logic [4:0] rm_post, rn_post;
	swap sw (.i0(rm), .i1(rn), .swap, .out0(rm_post), .out1(rn_post));
									
	logic [04:0] rda, rdb;
	logic inverted_clk;
	logic [63:0] alu_out, mem_out, mul_out, wdata, dA, dB;
	//not #50 inv (inverted_clk, clk);	
	mux2_1_5x rdtora_mux (.i0(rm_post), .i1(rd), .sel(RdToRdA), .out(rda));
	mux2_1_5x rdtorb_mux (.i0(rn_post), .i1(rd), .sel(RdToRdB), .out(rdb));
	mux4_1_64x wdata_mux (.i00(alu_out), .i01(mem_out), .i10(mul_out), .i11('0), .sel0(RegWData[0]), .sel1(RegWData[1]), .out(wdata));
	regfile	r (.clk, .WriteRegister(rd), .RegWrite, .WriteData(wdata), 
				   .ReadRegister1(rda), .ReadRegister2(rdb), .ReadData1(dA), .ReadData2(dB));
					
	logic [63:0] zeimm12, seimm9, imm, ALUA;				
	zero_extender #(52) imm12_ze (.in(imm12), .out(zeimm12));
	sign_extender #(55) imm9_se (.in(imm9), .out(seimm9));
	mux2_1_64x imm12alu_mux (.i0(seimm9), .i1(zeimm12), .sel(Imm12ALU), .out(imm));
	mux2_1_64x immalu_mux (.i0(dA), .i1(imm), .sel(ImmALUA), .out(ALUA));
	
	logic [63:0] shiftres, ALUB;
	shifter s (.value(dB), .direction(ShiftDir), .distance(shamt), .result(shiftres));
	mux2_1_64x shifttoalub_mux (.i0(dB), .i1(shiftres), .sel(ShiftToALUB), .out(ALUB));
	
	logic [63:0] mult_dummy;
	mult m (.A(dA), .B(dB), .doSigned(1'b1), .mult_low(mul_out), .mult_high(mult_dummy));

	logic ALU_Neg, ALU_Oflow, ALU_Cout;
	alu al_unit (.A(ALUA), .B(ALUB), .cntrl(ALUCntrl), .result(alu_out), .negative(ALU_Neg), .zero(ALU_Zero), .overflow(ALU_Oflow), .carryout(ALU_Cout));
	
	logic zflag, oflag, nflag, cflag;
	flag_handler fh (.clk, .reset, .en(FlagE), .zero_in(ALU_Zero), .oflow_in(ALU_Oflow), .neg_in(ALU_Neg), .cout_in(ALU_Cout),
						  .zero(zflag), .overflow(oflag), .negative(nflag), .carry_out(cflag));
	xor #50 lt (LT, oflag, nflag);
	
	datamem mem (.address(alu_out), .write_enable(MemWr), .read_enable(ReadMem), .write_data(dA), 
				    .clk, .xfer_size(4'b1000), .read_data(mem_out));
endmodule

module processor_testbench();
	logic clk, reset;
	
	// Simulated clock for the testing
	parameter clock_period = 150000;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	processor dut (.*);
	
	initial begin
		reset <= 1; 				  	  @(posedge clk);
		reset <= 0;			repeat(500)@(posedge clk);
		$stop;
	end
endmodule