module edecoder5_32(i4, i3, i2, i1, i0, e, 
							o0, o1, o2, o3, o4, o5, o6, o7,
							o8, o9, o10, o11, o12, o13, o14, o15,
							o16, o17, o18, o19, o20, o21, o22, o23,
							o24, o25, o26, o27, o28, o29, o30, o31);
	input logic i4, i3, i2, i1, i0, e; 
	output logic o0, o1, o2, o3, o4, o5, o6, o7,
					 o8, o9, o10, o11, o12, o13, o14, o15,
				    o16, o17, o18, o19, o20, o21, o22, o23,
					 o24, o25, o26, o27, o28, o29, o30, o31;
					 
	logic e0, e1, e2, e3;
	logic t0, t1, t2, t3, t4, t5, t6, t7,
			t8, t9, t10, t11, t12, t13, t14, t15,
			t16, t17, t18, t19, t20, t21, t22, t23,
			t24, t25, t26, t27, t28, t29, t30, t31;
	
	edecoder2_4 s (.i1(i4), .i0(i3), .e(1), 
						.o0(e0), .o1(e1), .o2(e2), .o3(e3));

	edecoder3_8 d0 (.i2, .i1, .i0, .e(e0), 
						.o0(t0), .o1(t1), .o2(t2), .o3(t3), .o4(t4), 
						.o5(t5), .o6(t6), .o7(t7));
	edecoder3_8 d1 (.i2, .i1, .i0, .e(e1), 
						.o0(t8), .o1(t9), .o2(t10), .o3(t11), .o4(t12), 
						.o5(t13), .o6(t14), .o7(t15));
	edecoder3_8 d2 (.i2, .i1, .i0, .e(e2), 
						.o0(t16), .o1(t17), .o2(t18), .o3(t19), .o4(t20), 
						.o5(t21), .o6(t22), .o7(t23));
	edecoder3_8 d3 (.i2, .i1, .i0, .e(e3), 
						.o0(t24), .o1(t25), .o2(t26), .o3(t27), .o4(t28), 
						.o5(t29), .o6(t30), .o7(t31));
	
	and a0 (o0, e, t0);
	and a1 (o1, e, t1);
	and a2 (o2, e, t2);
	and a3 (o3, e, t3);
	and a4 (o4, e, t4);
	and a5 (o5, e, t5);
	and a6 (o6, e, t6);
	and a7 (o7, e, t7);
	and a8 (o8, e, t8);
	and a9 (o9, e, t9);
	and a10 (o10, e, t10);
	and a11 (o11, e, t11);
	and a12 (o12, e, t12);
	and a13 (o13, e, t13);
	and a14 (o14, e, t14);
	and a15 (o15, e, t15);
	and a16 (o16, e, t16);
	and a17 (o17, e, t17);
	and a18 (o18, e, t18);
	and a19 (o19, e, t19);
	and a20 (o20, e, t20);
	and a21 (o21, e, t21);
	and a22 (o22, e, t22);
	and a23 (o23, e, t23);
	and a24 (o24, e, t24);
	and a25 (o25, e, t25);
	and a26 (o26, e, t26);
	and a27 (o27, e, t27);
	and a28 (o28, e, t28);
	and a29 (o29, e, t29);
	and a30 (o30, e, t30);
	and a31 (o31, e, t31);
endmodule

module edecoder5_32_testbench();
	logic i4, i3, i2, i1, i0, e; 
	logic o0, o1, o2, o3, o4, o5, o6, o7,
			o8, o9, o10, o11, o12, o13, o14, o15,
         o16, o17, o18, o19, o20, o21, o22, o23,
     		o24, o25, o26, o27, o28, o29, o30, o31;
			
	edecoder5_32 dut (.*);
	
	initial begin
		// Turn all off
		{i4, i3, i2, i1, i0, e} = 0; 			#10;
		
		// test first decoder
		// 0 to first decoder -> 0 OVERALL
		{i4, i3, i2, i1, i0} = 0; 	e <= 0; 	#10;
											e <= 1;	#10;
		// 1 from first decoder -> 1 OVERALL
		{i4, i3, i2, i1, i0} = 1; 	      	#10;
											e <= 0;	#10;
		// end first decoder test
		
		// test second decoder
		// 2 to second decoder -> 10 OVERALL
		{i4, i3, i2, i1, i0} = 10; 	 	   #10;
											e <= 1;	#10;
		// 3 from second decoder -> 11 OVERALL
		{i4, i3, i2, i1, i0} = 11; 	   	#10;
											e <= 0;	#10;
		// end second decoder test
		
		// test third decoder
		// 4 to third decoder -> 20 OVERALL
		{i4, i3, i2, i1, i0} = 20; 	   	#10;
											e <= 1;	#10;
		// 5 from third decoder -> 21 OVERALL
		{i4, i3, i2, i1, i0} = 21; 	    	#10;
											e <= 0;	#10;
		// end third decoder test
		
		// test fourth decoder
		// 6 to fourth decoder -> 30 OVERALL
		{i4, i3, i2, i1, i0} = 30; 	   	#10;
											e <= 1;	#10;
		// 7 from fourth decoder -> 31 OVERALL
		{i4, i3, i2, i1, i0} = 31; 	   	#10;
											e <= 0;	#10;
		// end fourth decoder test
	end
endmodule