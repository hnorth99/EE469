module mux32_1(i0, i1, i2, i3, i4, i5, i6, i7, i8,
					i9, i10, i11, i12, i13, i14, i15,
					i16, i17, i18, i19, i20, i21, i22, i23, 
					i24, i25, i26, i27, i28, i29, i30, i31,
					sel0, sel1, sel2, sel3, sel4, out);
					
	input logic i0, i1, i2, i3, i4, i5, i6, i7, i8,
					i9, i10, i11, i12, i13, i14, i15,
					i16, i17, i18, i19, i20, i21, i22, i23, 
					i24, i25, i26, i27, i28, i29, i30, i31,
					sel0, sel1, sel2, sel3, sel4;
	output logic out;
	
	logic v0, v1;
	
	mux16_1 m0 (.i0, .i1, .i2, .i3, .i4, .i5, .i6, .i7, .i8,
					.i9, .i10, .i11, .i12, .i13, .i14, .i15,
					.sel0, .sel1, .sel2, .sel3, .out(v0));
	mux16_1 m1 (.i0(i16), .i1(i17), .i2(i18), .i3(i19), .i4(i20), 
					.i5(i21), .i6(i22), .i7(i23), .i8(i24), .i9(i25), 
					.i10(i26), .i11(i27), .i12(i28), .i13(i29), 
					.i14(i30), .i15(i31),
					.sel0, .sel1, .sel2, .sel3, .out(v1));
	mux2_1 m2  (.i0(v0), .i1(v1), .sel(sel4), 
			      .out(out));

endmodule

module mux32_1_testbench();
	logic i0, i1, i2, i3, i4, i5, i6, i7, i8,
			i9, i10, i11, i12, i13, i14, i15,
			i16, i17, i18, i19, i20, i21, i22, i23, 
			i24, i25, i26, i27, i28, i29, i30, i31,
			sel0, sel1, sel2, sel3, sel4;
	logic out;
 
	mux32_1 dut (.i0, .i1, .i2, .i3, .i4, .i5, .i6, .i7, .i8,
					 .i9, .i10, .i11, .i12, .i13, .i14, .i15,
					 .i16, .i17, .i18, .i19, .i20, .i21, .i22, .i23, 
					 .i24, .i25, .i26, .i27, .i28, .i29, .i30, .i31,
					 .sel0, .sel1, .sel2, .sel3, .sel4, .out);
	
	initial begin
		// Zero everything
		{i0, i1, i2, i3, i4, i5, i6, i7, i8,
		 i9, i10, i11, i12, i13, i14, i15,
		 i16, i17, i18, i19, i20, i21, i22, i23, 
		 i24, i25, i26, i27, i28, i29, i30, i31,
		 sel0, sel1, sel2, sel3, sel4} = 0;				#10;
		
		// Test first mux
		// Test 0th entry in mux 1 -> OVERALL ENTRY 0
		{sel4, sel3, sel2, sel1, sel0} = 0;
		i0 = 1; 											#10;
		i0 = 0; 											#10;
		// Test 6th entry in mux 1 -> OVERALL ENTRY 6
		{sel4, sel3, sel2, sel1, sel0} = 6;
		i6 = 1; 											#10;
		i6 = 0; 											#10;
		// Test 14th entry in mux 1 -> OVERALL ENTRY 14
		{sel4, sel3, sel2, sel1, sel0} = 14;
		i14 = 1; 											#10;
		i14 = 0; 											#10;
		// End Mux 1 tests
		
		// Test second mux
		// Test 4th entry in mux 2 -> OVERALL ENTRY 20
		{sel4, sel3, sel2, sel1, sel0} = 20;
		i20 = 1; 											#10;
		i20 = 0; 											#10;
		// Test 12th entry in mux 2 -> OVERALL ENTRY 28
		{sel4, sel3, sel2, sel1, sel0} = 28;
		i28 = 1; 											#10;
		i28 = 0; 											#10;
		// Test 15th entry in mux 2 -> OVERALL ENTRY 31
		{sel4, sel3, sel2, sel1, sel0} = 31;
		i31 = 1; 											#10;
		i31 = 0; 
		// End Mux 2 test
	end
endmodule