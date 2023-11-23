/*******************************************************************************
* Copyright (C) 2018-2022 Intel Corporation
* 
* This code and the related documents are Intel copyrighted materials, and 
* your use of them is governed by the express license under which they were 
* provided to you ("License"). Unless the License provides otherwise, you may 
* not use, modify, copy, publish, distribute, disclose or transmit this 
* code or the related documents without Intel's prior written permission.
*
* This code and the related documents are provided as is, with no express 
* or implied warranties, other than those that are expressly stated in the 
* License.
*
*******************************************************************************/

`timescale 1 ns/1 ns

module mult8x8_tb();

	// Wires to connect to DUT
	reg clk, reset_a, start;
	reg [7:0] dataa, datab;
	wire [15:0] product8x8_out;
	wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;
	
	// Instantiate unit under test (mult_control)
	mult8x8 mult8x8_1 (.clk(clk), .reset_a(reset_a), .dataa(dataa), .datab(datab),
		.product8x8_out(product8x8_out), .done_flag(done_flag), .start(start), 
		.seg_a(seg_a), .seg_b(seg_b), .seg_c(seg_c), .seg_d(seg_d), 
		.seg_e(seg_e), .seg_f(seg_f), .seg_g(seg_g));
		
	// Process to create clock signal
	initial begin
		clk = 0;
		forever clk = #25 ~clk;
	end

	// Set the reset control
	initial begin
		reset_a = 1'b1;
		#50 reset_a = 1'b0;
	end

	// Set input values to control start signal
	initial begin
		start = 1'b1;
		#50 ;
		forever begin
			start = 1'b1;
			#50 start = 1'b0;
			@(negedge done_flag) ;
			#25 ;
		end
	end
	
	// Process to control data inputs
	initial begin
		dataa = 8'hFF;
		datab = 8'hFF;
		#50 ;
		forever begin
			@(negedge done_flag)
			#25 dataa = dataa + 24;
			datab = datab + 51;
		end
	end
	
endmodule
