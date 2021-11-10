module processor();

	instruction_handler ih (clk, reset, imm26, imm19, uncondBr, brTaken, instr);

	instruction_decoder id (instruction, LT, ALU_Zero,
									UncondBr, BrTaken, ImmALUA, RegWrite, 
									RdToRdB, Imm12ALU, RegWData, ShiftToALUB, ShiftDir,
									ReadMem, MemWr, RdToRdA, ALUCntrl, FlagE,
									rd, rm, rn, imm26, imm19, imm12, imm9,
									shamt);
									
									
	mux2_1_32x rdtora_mux (i0, i1, sel, out);
	mux2_1_32x rdtorb_mux (i0, i1, sel, out);
	mux4_1_64x redwdata_mux (i00, i01, i10, i11, sel0, sel1, out);
	regfile	r (.clk, .WriteRegister(rd), .RegWrite, .WriteData(), 
				   .ReadRegister1, .ReadRegister2(), .ReadData1(dA), .ReadData2(dB));
					
	sign_extender #(52) imm12_se (in, out);
	sign_extender #(55) imm9_se (in, out);
	mux2_1_64x imm12alu_mux (.i0(), .i1(), .sel(), .out());
	mux2_1_64x immalu_mux (.i0(), .i1(), .sel(), .out());
	
	shifter s (value, direction, distance,result);
	mux2_1_64x shifttoalub_mux (.i0(), .i1(), .sel(), .out());
	
	mult m (A, B, doSigned, mult_low, mult_high);
					
	alu(A, B, cntrl, result, negative, zero, overflow, carryout);
	
	flag_handler(clk, reset, en, zero_in, oflow_in, neg_in, cout_in,
						  zero, overflow, negative, carry_out);
	xor #50 (out, a, b)
						  
	datamem mem (address, write_enable, read_enable, write_data, 
				    clk, xfer_size, read_data);
endmodule