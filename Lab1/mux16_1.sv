module mux16_1(i0, i1, i2, i3, i4, i5, i6, i7, i8,
					i9, i10, i11, i12, i13, i14, i15,
					sel0, sel1, sel2, sel3, out);
					
	input logic i0, i1, i2, i3, i4, i5, i6, i7, 
				   i8, i9, i10, i11, i12, i13, i14, i15,
					sel0, sel1, sel2, sel3;
	output logic out;
	
	logic v0, v1, v2, v3;
	
	mux4_1 (.i00(i0), .i01(i1), .i10(i2), .i11(i3), .sel0(sel2), .sel1(sel3), 
			  .out(v0));
	mux4_1 (.i00(i4), .i01(i5), .i10(i6), .i11(i7), .sel0(sel2), .sel1(sel3), 
			  .out(v1));
	mux4_1 (.i00(i8), .i01(i9), .i10(i10), .i11(i11), .sel0(sel2), .sel1(sel3), 
			  .out(v2));
	mux4_1 (.i00(i12), .i01(i13), .i10(i14), .i11(i15), .sel0(sel2), .sel1(sel3), 
			  .out(v3));
	mux4_1 (.i00(v0), .i01(v1), .i10(v2), .i11(v3), .sel0(sel0), .sel1(sel1), 
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
	
	integer i;
	initial begin
		for(i = 0; i < 64; i++) begin
			//{sel1, sel0, i00, i01, i10, i11} = i; #10;
		end
	end
endmodule