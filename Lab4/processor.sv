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
									
	/*************************CONTROL LOGIC QUEUES ******************************************************/			
	// Control Logic Queue for RegFileRead Pipeline Stage
	logic SwapO, RdToRdAO, RdToRdBO, ShiftDirO, ShiftToALUBO, Imm12ALUO, ImmALUAO;
	logic [5:0] ShamtO;
	logic [11:0] Imm12O;
	logic [8:0] Imm9O;
	regfileread_queue rfrq (.clk, .reset, .Swap(swap), .RdToRdA, .RdToRdB, .Shamt(shamt), .ShiftDir,
								 .ShiftToALUB, .Imm12ALU, .ImmALUA, .Imm12(imm12), .Imm9(imm9),
								 .SwapO, .RdToRdAO, .RdToRdBO, .ShamtO, .ShiftDirO,
								 .ShiftToALUBO, .Imm12ALUO, .ImmALUAO, .Imm12O, .Imm9O);
	// Control Logic Queue for ALU Pipeline Stage
	logic [2:0] ALUCntrlO;
	logic FlagEO;
	alu_queue aq (.clk, .reset, .ALUCntrl, .FlagE, .ALUCntrlO, .FlagEO);
	
	// Control Logic Queue for DataMem Pipeline Stage
	logic ReadMemO, MemWrO;
	datamem_queue dmq (.clk, .reset, .ReadMem, .MemWr, .ReadMemO, .MemWrO);
	
	// Control Logic Queue for RegFileWrite Stage
	logic RegWrtO;
	logic [1:0] RegWDataO;
	logic [4:0] RdO;
	regfilewrite_queue rfwq (.clk, .reset, .RegWrt(RegWrite), .RegWData, .Rd(rd), .RegWrtO, .RegWDataO, .RdO);
	/************************* END CONTROL LOGIC QUEUES ***************************************************/
	
	/************************* PIPELINE: REGFILE STAGES *********************************************************/
	// Register for regfileread stage
	logic [4:0] rd_regfileread, rm_regfileread, rn_regfileread;
	register5_3x rfreadgate (.clk, .reset, .din1(rd), .din2(rm), .din3(rn), 
					             .dout1(rd_regfileread), .dout2(rm_regfileread), .dout3(rn_regfileread));
	// Register for regfilewrite stage
	logic [63:0] mem_out, aluout_datamem, mulout_datamem;
	logic [63:0] dmread_regfilewrite, aluout_regfilewrite, mulout_regfilewrite;
	register64_3x rfwritegate (.clk, .reset, .a(mem_out), .b(aluout_datamem), .c(mulout_datamem),
										.outA(dmread_regfilewrite), .outB(aluout_regfilewrite), 
										.outC(mulout_regfilewrite));
	
	logic [4:0] rm_post, rn_post;
	swap sw (.i0(rm_regfileread), .i1(rn_regfileread), .swap(SwapO), .out0(rm_post), .out1(rn_post));
									
	logic [04:0] rda, rdb;
	logic inverted_clk;
	logic [63:0] mul_out, wdata, dA, dB;
	//not #50 inv (inverted_clk, clk);	
	mux2_1_5x rdtora_mux (.i0(rm_post), .i1(rd_regfileread), .sel(RdToRdAO), .out(rda));
	mux2_1_5x rdtorb_mux (.i0(rn_post), .i1(rd_regfileread), .sel(RdToRdBO), .out(rdb));
	mux4_1_64x wdata_mux (.i00(aluout_regfilewrite), .i01(dmread_regfilewrite), .i10(mulout_regfilewrite), 
								 .i11('0), .sel0(RegWDataO[0]), .sel1(RegWDataO[1]), .out(wdata));
	regfile	r (.clk, .WriteRegister(RdO), .RegWrite(RegWrtO), .WriteData(wdata), 
				   .ReadRegister1(rda), .ReadRegister2(rdb), .ReadData1(dA), .ReadData2(dB)); //dA passed forward
					
	logic [63:0] zeimm12, seimm9, imm, ALUA;				
	zero_extender #(52) imm12_ze (.in(Imm12O), .out(zeimm12));
	sign_extender #(55) imm9_se (.in(Imm9O), .out(seimm9));
	mux2_1_64x imm12alu_mux (.i0(seimm9), .i1(zeimm12), .sel(Imm12ALUO), .out(imm));
	mux2_1_64x immalu_mux (.i0(dA), .i1(imm), .sel(ImmALUAO), .out(ALUA));					  //ALUA passed forward
	
	logic [63:0] shiftres, ALUB;
	shifter s (.value(dB), .direction(ShiftDirO), .distance(ShamtO), .result(shiftres));
	mux2_1_64x shifttoalub_mux (.i0(dB), .i1(shiftres), .sel(ShiftToALUBO), .out(ALUB));  //ALUB passed forward
	
	logic [63:0] mult_dummy;
	mult m (.A(dA), .B(dB), .doSigned(1'b1), .mult_low(mul_out), .mult_high(mult_dummy)); //mul_out passed forward
	/************************* PIPELINE: REGFILE STAGES END **************************************************/

	/************************* PIPELINE: ALU STAGE  *********************************************************/
	// Register for ALU/EXEC stage
	logic [63:0] da_alu;
	D_FF_64 daalu (.clk, .reset, .d(dA), .q(da_alu));									//da_alu passed forward
	logic [63:0] a_alu, b_alu, mulout_alu;
	register64_3x alugate (.clk, .reset, .a(ALUA), .b(ALUB), .c(mul_out),
										.outA(a_alu), .outB(b_alu), .outC(mulout_alu)); //mulout_alu passed forward
	
	logic [63:0] alu_out;
	logic ALU_Neg, ALU_Oflow, ALU_Cout;
	alu al_unit (.A(a_alu), .B(b_alu), .cntrl(ALUCntrlO), .result(alu_out), .negative(ALU_Neg), .zero(ALU_Zero), 
					 .overflow(ALU_Oflow), .carryout(ALU_Cout)); 						//alu_out passed forward
	
	logic zflag, oflag, nflag, cflag;
	flag_handler fh (.clk, .reset, .en(FlagEO), .zero_in(ALU_Zero), .oflow_in(ALU_Oflow), .neg_in(ALU_Neg), 
							.cout_in(ALU_Cout), .zero(zflag), .overflow(oflag), .negative(nflag), .carry_out(cflag));
	xor #50 lt (LT, oflag, nflag);
	/************************* PIPELINE: ALU STAGE END  ******************************************************/
	
	/************************* PIPELINE: DATAMEM STAGE  ******************************************************/
	// Register for ALU/EXEC stage
	logic [63:0] da_datamem;
	register64_3x datamemgate (.clk, .reset, .a(alu_out), .b(mulout_alu), .c(da_alu),
										.outA(aluout_datamem), .outB(mulout_datamem), .outC(da_datamem));
																													//mulout_datamem passed forward
																													//aluout_datamem passed forward

	datamem mem (.address(aluout_datamem), .write_enable(MemWrO), .read_enable(ReadMemO), .write_data(da_datamem), 
				    .clk, .xfer_size(4'b1000), .read_data(mem_out));								//mem_out passed forward
	/************************* PIPELINE: DATAMEM STAGE END  ******************************************************/
endmodule

module processor_testbench();
	logic clk, reset;
	
	// Simulated clock for the testing
	parameter clock_period = 50000;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	processor dut (.*);
	
	initial begin
		reset <= 1; 				  	  @(posedge clk);
		reset <= 0;			repeat(30)@(posedge clk);
		$stop;
	end
endmodule