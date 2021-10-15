module register_file(clk, reset, wsel, e, din, rsel1, rsel2, rd1, rd2);
	input logic clk, reset, e;
	input logic [63:0] din;
	input logic [4:0] wsel, rsel1, rsel2;
	output logic [63:0] rd1, rd2;
	
	logic [31:0] o;
	logic [63:0] dout [31:0];
	
	edecoder5_32 dec(.i(wsel), .e(e), .o(o));
	register64_32x r64_32(.clk(clk), .reset(reset), .din(din), .en(o), .dout(dout));
	
	genvar k;
	generate
		for (k = 0; k < 64; k++) begin : eachBit
			mux32_1 m32x1_1(.i(dout[k][31:0]), .sel(rsel1), .out(rd1));
			mux32_1 m32x1_2(.i(dout[k][31:0]), .sel(rsel2), .out(rd2));
		end
	endgenerate
endmodule

module top_level_testbench();
	logic clk, reset, e;
	logic [63:0] din;
	logic [4:0] wsel, rsel1, rsel2;
	logic [63:0] rd1, rd2;

	
	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	register_file dut (.*);
	
	initial begin
		reset <= 0;	din <= 64'd0;	wsel <= 5'd3; e <= 0; 					@(posedge clk);
		reset <= 1;																		@(posedge clk);
		reset <= 0; 														         @(posedge clk);
		
		din <= 64'd0; e <= 1; rsel1 <= 5'd3; rsel2 <= 5'd31;	repeat(2)@(posedge clk); // all should keep outputting zero
		din <= 64'd33; 	     											repeat(2)@(posedge clk); // rd1 should be 33
		din <= 64'd27; wsel <= 5'd31; e <= 0;						repeat(2)@(posedge clk); // stay the same
		e <= 1;																repeat(2)@(posedge clk); // rd2 should be 0 still
		wsel <= 5'd30;														repeat(2)@(posedge clk); // rd2 should be 27
		din <= 64'd2147483647; 										   repeat(2)@(posedge clk); // rd2 largest 32 bit number
		din <= 5'd10; wsel <= 5'd3;									repeat(2)@(posedge clk); // overwrite rd1 to be 10
		rsel1 <= 5'd0; rsel2 <= 5'd1;   								repeat(2)@(posedge clk); // rd1 and rd2 should be nothing
		din <= 64'd16; e <= 0;											repeat(4)@(posedge clk); // stop writting everywhere
		$stop;
	end 
endmodule
