module edecoder3_8(i, e, o);
	input logic [2:0] i;
	input logic e;
	output logic [7:0] o;
	
	logic noti2;
	not n (noti2, i[2]);
	
	logic [7:0] t;
	edecoder2_4 ed0 (.i1(i[1]), .i0(i[0]), .e(noti2), .o0(t[0]), 
						  .o1(t[1]), .o2(t[2]), .o3(t[3]));
	edecoder2_4 ed1 (.i1(i[1]), .i0(i[0]), .e(i[2]), .o0(t[4]), 
						  .o1(t[5]), .o2(t[6]), .o3(t[7]));

	genvar k;
	generate
		for (k = 0; k < 8; k++) begin : eachAND
			and aGate (o[k], e, t[k]);
		end
	endgenerate
endmodule

module edecoder3_8_testbench();
	logic [2:0] i;
	logic e;
	logic [7:0] o;
	
	edecoder3_8 dut (.*);
	
	integer k;
	initial begin
		for(k = 0; k < 16; k++) begin
			{i, e} = k; #10;
		end
	end
endmodule