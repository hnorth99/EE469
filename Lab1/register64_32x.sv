module register64_32x(clk, reset, din, en, dout);
	input logic clk, reset;
	input logic [31:0] en;
	input logic [63:0] din;
	output logic [63:0] dout [31:0];
	
	genvar i;
	generate
		for (i = 0; i < 31; i++) begin : eachRegister
			register64 register (.clk, .reset, .en(en[i]), .din, .dout(dout[i]));
		end
	endgenerate
	
	register64 zero_register (.clk, .reset, .en(0), .din(0), .dout(dout[31]));
	
endmodule

module register64_32x_testbench();
	logic clk, reset;
	logic [31:0] en;
	logic [63:0] din;
	logic [63:0] dout [31:0];
	
	// Simulated clock for the testing
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	register64_32x dut (.*);
	
	initial begin
		reset <= 0;	din <= 64'd0;	en[31:0] <= 0;								@(posedge clk);
		reset <= 1;																		@(posedge clk);
		reset <= 0; 														         @(posedge clk);
		
		din <= 64'd0; 	        											repeat(2)@(posedge clk); // all should keep outputting zero
		din <= 64'd33; 	     											repeat(2)@(posedge clk); // still zeros
		din <= 64'd27; 	     en[4] <= 1;							repeat(2)@(posedge clk); // input a 27 into reg 4
		din <= 64'd1; 			  en[31] <= 1;		en[4] <= 0;		repeat(2)@(posedge clk); // input a 1 into reg 31 -> should stay zero
		din <= 64'd2147483647; en[0] <= 1;	   en[31] <= 0;   repeat(2)@(posedge clk); // input largest 32 bit number int reg 0
		din <= 64'd44;			  en[4] <= 1;		en[0] <= 0;    repeat(2)@(posedge clk); // overwrite reg 4 with a 44
		din <= 64'd16;			  en[31:0] <= 32'b0;					repeat(4)@(posedge clk); // stop writting everywhere
		$stop;
	end 
endmodule

