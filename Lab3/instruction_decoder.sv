module instruction_decoder(instruction, LT, ALU_Zero,
									UncondBr, BrTaken, ImmALUA, RegWrite, 
									RdToRdB, Imm12ALU, RegWData, ShiftToALUB, ShiftDir,
									ReadMem, MemWr, RdToRdA, ALUCntrl, FlagE,
									rd, rm, rn, imm26, imm19, imm12, imm9,
									shamt);
									
	input logic [31:0] instruction;
	input logic LT, ALU_Zero;
	output logic 		 UncondBr, BrTaken, ImmALUA, RegWrite, RdToRdB, Imm12ALU, 
							 ShiftToALUB, ShiftDir, ReadMem, MemWr, RdToRdA, FlagE;
	output logic [1:0] RegWData;
	output logic [2:0] ALUCntrl;
	output logic [4:0] rd, rm, rn;
	output logic [25:0] imm26;
	output logic [18:0] imm19;
	output logic [11:0] imm12;
	output logic [8:0]  imm9;
	output logic [5:0]  shamt;
	
	logic [16:0] control_code;
		
	enum {ADDI, ADDS, B, BLT, CBZ, LDUR, LSL, LSR, MUL, STUR, SUBS} operation;
	always_comb begin
		//I type:
		// ADDI : 0x244 = 10 0100 0100
		// [31:22] = OPCODE
		// [21:10] = imm12
		// [09:05] = rn
		// [04:00] = rd
		case (instruction[31:22])
			10'b1001000100: begin 
									operation = ADDI;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = instruction[21:10];
									imm9      = 9'bX;
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = 5'bX;
									shamt		 = 6'bX;
								 end
		endcase
		
		//D type:
		//	STUR : 0x7C0
		// LDUR : 0x7C2
		// [31:21] = OPCODE
		// [20:12] = imm9
		// [11:10] = 00
		// [09:05] = rn
		// [04:00] = rd
		case (instruction[31:21])
			11'b11111000000: begin 
									operation = STUR;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = instruction[20:12];
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = 5'bX;
									shamt		 = 6'bX;
								 end
			11'b11111000010: begin 
									operation = LDUR;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = instruction[20:12];
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = 5'bX;
									shamt		 = 6'bX;
								 end
		endcase
		
		//B type: 
		// B : 0x05
		// [31:26] = OPCODE
		// [25:00] = imm26
		case (instruction[31:26])
			6'b000101: begin 
									operation = B;
									imm26 	 = instruction[25:00];
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = 5'bX;
									rd 		 = 5'bX;
									rm			 = 5'bX;
									shamt		 = 6'bX;
						  end
		endcase
		
		//CB type:
		// B.LT : 0x0B
		// CBZ : 0xB4
		// [31:24] = OPCODE
		// [23:05] = imm19
		// [04:00] = rd
		case (instruction[31:24])
			8'b00001011: begin 
									operation = BLT;
									imm26 	 = 26'bX;
									imm19     = instruction[23:05];
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = 5'bX;
									rd 		 = instruction[04:00];
									rm			 = 5'bX;
									shamt		 = 6'bX;
						  end
			8'b10110100: begin 
									operation = CBZ;
									imm26 	 = 26'bX;
									imm19     = instruction[23:05];
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = 5'bX;
									rd 		 = instruction[04:00];
									rm			 = 5'bX;
									shamt		 = 6'bX;
						  end
		endcase
		
		//R type:
		// ADDS : 0x558
		// SUBS : 0x758
		// LSL : 0x69B
		// LSR : 0x69A
		// MUL : 0x498
		// [31:21] = OPCODE
		// [20:16] = rm
		// [15:10] = shamt
		// [09:05] = rn
		// [04:00] = rd
		case (instruction[31:21])
			11'b10101011000: begin 
									operation = ADDS;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = instruction[20:16];
									shamt		 = instruction[15:10];
								 end
			11'b11101011000: begin 
									operation = SUBS;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = instruction[20:16];
									shamt		 = instruction[15:10];
								 end
			11'b11010011011: begin 
									operation = LSL;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = instruction[20:16];
									shamt		 = instruction[15:10];
								 end
			11'b11010011010: begin 
									operation = LSR;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = instruction[20:16];
									shamt		 = instruction[15:10];
								 end
			11'b10010011000: begin 
									operation = MUL;
									imm26 	 = 26'bX;
									imm19     = 19'bX;
									imm12 	 = 12'bX;
									imm9      = 9'bX;
									rn 		 = instruction[09:05];
									rd 		 = instruction[04:00];
									rm			 = instruction[20:16];
									shamt		 = 5'b11111;
								 end
		endcase
		
		case (operation)
			ADDI: control_code = 17'bX01101000XX0X0100;
			ADDS: control_code = 17'bX0010X000XX000101;
			B: 	control_code = 17'b11X0XXXXXXX0XXXX0;
			BLT: 	begin
						if(LT) begin 
							control_code = 17'b01X0XXXXXXX0XXXX0;
						end
						else begin
							control_code = 17'b00X0XXXXXXX0XXXX0;
						end
					end
			CBZ: 	begin
						if(ALU_Zero) begin 
							control_code = 17'b01X01XXX0XX0X0000;
						end
						else begin
							control_code = 17'b00X01XXX0XX0X0000;
						end
					end
			LDUR: control_code = 17'bX01100010X10X0100;
			LSL:	control_code = 17'bX0X10X0010X0X0000;
			LSR:	control_code = 17'bX0X10X0011X0X0000;
			MUL:	control_code = 17'bX0X10X10XXX00XXX0;
			STUR:	control_code = 17'bX01000XX0XX110100;
			SUBS:	control_code = 17'bX0010X000XX001001;
		endcase
	end
	
	assign UncondBr 		= control_code[16];
	assign BrTaken  		= control_code[15];
	assign ImmALUA	 		= control_code[14];
	assign RegWrite 		= control_code[13];
	assign RdToRdB  		= control_code[12];
	assign Imm12ALU 		= control_code[11];
	assign RegWData 		= control_code[10:09];
	assign ShiftToALUB 	= control_code[08];
	assign ShiftDir		= control_code[07];	
	assign ReadMem			= control_code[06];
	assign MemWr			= control_code[05];
	assign RdToRdA			= control_code[04];
	assign ALUCntrl		= control_code[03:01];
	assign FlagE			= control_code[00];
	
endmodule