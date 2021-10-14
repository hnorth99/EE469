module mux2_1(i0, i1, sel, out);
	input logic i0, i1, sel;
	output logic out;

	// out = (i1 & sel) | (i0 & ~sel);
	logic tL, tR, selNot;
	not n (selNot, sel);
	and andL (tL, i1, sel);
	and andR (tR, i0, selNot);
	or orF (out, tL, tR);
endmodule

module mux2_1_testbench();
	logic i0, i1, sel;
	logic out;
	
	mux2_1 dut (.out, .i0, .i1, .sel);
	
	initial begin
		sel = 0; i0 = 0; i1 = 0; #10;
		sel = 0; i0 = 0; i1 = 1; #10;
		sel = 0; i0 = 1; i1 = 0; #10;
		sel = 0; i0 = 1; i1 = 1; #10;
		sel = 1; i0 = 0; i1 = 0; #10;
		sel = 1; i0 = 0; i1 = 1; #10;
		sel = 1; i0 = 1; i1 = 0; #10;
		sel = 1; i0 = 1; i1 = 1; #10;
	end
endmodule