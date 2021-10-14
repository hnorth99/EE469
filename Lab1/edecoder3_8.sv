module edecoder3_8(i2, i1, i0, e, o0, o1, o2, o3, o4, o5, o6, o7);
	input logic i2, i1, i0, e;
	output logic o0, o1, o2, o3, o4, o5, o6, o7;
	
	logic t0, t1, t2, t3, t4, t5, t6, t7;
	
	edecoder2_4 ed0 (.i1(i1), .i0(i0), .e(~i2), .o0(t0), .o1(t1), .o2(t2), .o3(t3));
	edecoder2_4 ed1 (.i1(i1), .i0(i0), .e(i2), .o0(t4), .o1(t5), .o2(t6), .o3(t7));

	and a0 (o0, e, t0);
	and a1 (o1, e, t1);
	and a2 (o2, e, t2);
	and a3 (o3, e, t3);
	and a4 (o4, e, t4);
	and a5 (o5, e, t5);
	and a6 (o6, e, t6);
	and a7 (o7, e, t7);
endmodule

module edecoder3_8_testbench();
	logic i2, i1, i0, e;
	logic o0, o1, o2, o3, o4, o5, o6, o7;
	
	edecoder3_8 dut (.*);
	
	integer i;
	initial begin
		for(i = 0; i < 16; i++) begin
			{i2, i1, i0, e} = i; #10;
		end
	end
endmodule