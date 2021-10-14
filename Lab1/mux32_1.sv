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
	mux2_1 (.i00(v0), .i01(v1), .sel(sel4), 
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
	
	integer i;
	initial begin
		for(i = 0; i < 64; i++) begin
			//{sel1, sel0, i00, i01, i10, i11} = i; #10;
		end
	end
endmodule