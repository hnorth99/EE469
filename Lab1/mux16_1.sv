module mux16_1(i0, i1, i2, i3, i4, i5, i6, i7, i8,
					i9, i10, i11, i12, i13, i14, i15,
					sel0, sel1, sel2, sel3, out);
					
	input logic i0, i1, i2, i3, i4, i5, i6, i7, 
				   i8, i9, i10, i11, i12, i13, i14, i15,
					sel0, sel1, sel2, sel3;
	output logic out;
	
	logic v0, v1, v2, v3;
	
	mux4_1 m0 (.i00(i0), .i01(i1), .i10(i2), .i11(i3), .sel1(sel1), .sel0(sel0), 
			     .out(v0));
	mux4_1 m1 (.i00(i4), .i01(i5), .i10(i6), .i11(i7), .sel1(sel1), .sel0(sel0), 
			     .out(v1));
	mux4_1 m2 (.i00(i8), .i01(i9), .i10(i10), .i11(i11), .sel1(sel1), .sel0(sel0),
			     .out(v2));
	mux4_1 m3 (.i00(i12), .i01(i13), .i10(i14), .i11(i15), .sel1(sel1), .sel0(sel0), 
			     .out(v3));
	mux4_1 m4 (.i00(v0), .i01(v1), .i10(v2), .i11(v3), .sel1(sel3), .sel0(sel2), 
			     .out(out));
endmodule

module mux16_1_testbench();
	logic i0, i1, i2, i3, i4, i5, i6, i7, i8,
			i9, i10, i11, i12, i13, i14, i15,
		   sel0, sel1, sel2, sel3;
	logic out;
 
	mux16_1 dut (.i0, .i1, .i2, .i3, .i4, .i5, .i6, .i7, .i8,
					 .i9, .i10, .i11, .i12, .i13, .i14, .i15,
					 .sel0, .sel1, .sel2, .sel3, .out);
	
	initial begin
		// Set all to zero
		{i0, i1, i2, i3, i4, i5, i6, i7, i8,
		 i9, i10, i11, i12, i13, i14, i15,
		 sel0, sel1, sel2, sel3} = 0; 			#10;
	
		// Mux 1 tests
		// Test 0th entry in mux 1 -> OVERALL ENTRY 0
		{sel3, sel2, sel1, sel0} = 0;
		i0 = 1; 											#10;
		i0 = 0; 											#10;
		// Test 2nd entry in mux 1 -> OVERALL ENTRY 2
		{sel3, sel2, sel1, sel0} = 2;
		i2 = 1; 											#10;
		i2 = 0; 											#10;
		// End Mux 1 tests
		
		// Mux 2 tests
		// Test 1st entry in mux 2 -> OVERALL ENTRY 5
		{sel3, sel2, sel1, sel0} = 5;
		i5 = 1; 											#10;
		i5 = 0;											#10;
		// Test 3rd entry in mux 2 -> OVERALL ENTRY 7
		{sel3, sel2, sel1, sel0} = 7;
		i7 = 1; 											#10;
		i7 = 0; 											#10;
		// End Mux 2 tests
		
		// Mux 3 tests
		// Test 0th entry in mux 3 -> OVERALL ENTRY 8
		{sel3, sel2, sel1, sel0} = 8;
		i8 = 1; 											#10;
		i8 = 0; 											#10;
		// Test 2nd entry in mux 3 -> OVERALL ENTRY 10
		{sel3, sel2, sel1, sel0} = 10;
		i10 = 1; 										#10;
		i10 = 0;											#10;
		// End Mux 3 tests
		
		// Mux 4 tests
		// Test 1st entry in mux 4 -> OVERALL ENTRY 13
		{sel3, sel2, sel1, sel0} = 13;
		i13 = 1; 										#10;
		i13 = 0; 										#10;
		// Test 4th entry in mux 4 -> OVERALL ENTRY 15
		{sel0, sel1, sel2, sel3} = 15;
		i15 = 1; 										#10;
		i15 = 0;											#10;
		// End Mux 4 tests
	end
endmodule