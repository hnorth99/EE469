`timescale 1ps/1ps

// This module will handle the flag registers by storing input signals
// into registers when enable signal is high
module flag_handler(clk, reset, en, zero_in, oflow_in, neg_in, cout_in,
						  zero, overflow, negative, carry_out);
	input logic clk, reset, en;
	input logic zero_in, oflow_in, neg_in, cout_in;
	output logic zero, overflow, negative, carry_out;
	
	eD_FF zDff (.clk, .reset, .en, .din(zero_in), .dout(zero));
	eD_FF oDff (.clk, .reset, .en, .din(oflow_in), .dout(overflow));
	eD_FF nDff (.clk, .reset, .en, .din(neg_in), .dout(negative));
	eD_FF cDff (.clk, .reset, .en, .din(cout_in), .dout(carry_out));
endmodule

module flag_handler_testbench();
	logic clk, reset, en;
	logic zero_in, oflow_in, neg_in, cout_in;
	logic zero, overflow, negative, carry_out;
	
	// Simulated clock for the testing
	parameter clock_period = 1000;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	flag_handler dut (.*);
	
	initial begin
		reset <= 0; neg_in <= 0; oflow_in <= 0; 
		cout_in <= 0; zero_in <= 0; en <=0;				@(posedge clk);
		reset <= 1;												@(posedge clk);
		reset <= 0; 											@(posedge clk);
		
		zero_in <= 1;  en <= 0; 				repeat(5)@(posedge clk);
							en <= 1;								@(posedge clk);
		neg_in <= 1; oflow_in <= 1; 
		cout_in <= 1; zero_in <= 1; en <=0; repeat(1)@(posedge clk);
		zero_in <= 0;								repeat(2)@(posedge clk);
		en <= 1; 									repeat(2)@(posedge clk);
		$stop;
	end
endmodule