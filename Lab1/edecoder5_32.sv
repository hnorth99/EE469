module edecoder5_32(i, e, o);
	input logic [4:0] i;
	input logic e;
	output logic [31:0] o;
					 
	logic [3:0] te;
	logic [31:0] t;
	edecoder2_4 s (.i1(i[4]), .i0(i[3]), .e(1'b1), 
						.o0(te[0]), .o1(te[1]), .o2(te[2]), .o3(te[3]));

	edecoder3_8 d0 (.i(i[2:0]), .e(te[0]), 
						.o(t[7:0]));
	edecoder3_8 d1 (.i(i[2:0]), .e(te[1]), 
						.o(t[15:8]));
	edecoder3_8 d2 (.i(i[2:0]), .e(te[2]), 
						.o(t[23:16]));
	edecoder3_8 d3 (.i(i[2:0]), .e(te[3]), 
						.o(t[31:24]));
	
	genvar k;
	generate
		for (k = 0; k < 32; k++) begin : eachAND
			and aGate (o[k], e, t[k]);
		end
	endgenerate
endmodule

module edecoder5_32_testbench();
	logic [4:0] i;
	logic e;
	logic [31:0] o;
			
	edecoder5_32 dut (.*);
	
	initial begin
		// Turn all off
		{i, e} = 0; 						#10;
		
		// test first decoder
		// 0 to first decoder -> 0 OVERALL
		i = 5'b0; 				e <= 0; 	#10;
									e <= 1;	#10;
		// 1 from first decoder -> 1 OVERALL
		i = 5'b00001; 	      			#10;
									e <= 0;	#10;
		// end first decoder test
		
		// test second decoder
		// 2 to second decoder -> 10 OVERALL
		i = 5'b01010; 	 	   			#10;
									e <= 1;	#10;
		// 3 from second decoder -> 11 OVERALL
		i = 5'b01011; 	   				#10;
									e <= 0;	#10;
		// end second decoder test
		
		// test third decoder
		// 4 to third decoder -> 20 OVERALL
		i = 5'b10100; 	   				#10;
									e <= 1;	#10;
		// 5 from third decoder -> 21 OVERALL
		i = 5'b10101;			 	    	#10;
									e <= 0;	#10;
		// end third decoder test
		
		// test fourth decoder
		// 6 to fourth decoder -> 30 OVERALL
		i = 5'b11110; 	   				#10;
									e <= 1;	#10;
		// 7 from fourth decoder -> 31 OVERALL
		i = 5'b11111; 	   				#10;
									e <= 0;	#10;
		// end fourth decoder test
	end
endmodule