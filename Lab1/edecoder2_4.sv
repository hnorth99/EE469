module edecoder2_4(i1, i0, e, o0, o1, o2, o3);
	input logic i1, i0, e;
	output logic o0, o1, o2, o3;
	
	logic i1Not, i0Not;
	not not1 (i1Not, i1);
	not not0 (i0Not, i0);
	
	and a0 (o0, e, i1Not, i0Not);
	and a1 (o1, e, i1Not, i0);
	and a2 (o2, e, i1, i0Not);
	and a3 (o3, e, i1, i0);
endmodule

module edecoder2_4_testbench();
	logic i1, i0, e;
	logic o0, o1, o2, o3;
	
	edecoder2_4 dut (.*);
	
	integer i;
	initial begin
		for(i = 0; i < 8; i++) begin
			{i1, i0, e} = i; #10;
		end
	end
endmodule	