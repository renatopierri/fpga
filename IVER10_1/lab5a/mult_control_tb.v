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

module mult_control_tb();

	// Wires to connect to DUT
	reg clk, reset_a, start;
	reg [1:0] count;
	wire [2:0] state_out;
	wire [1:0] input_sel, shift_sel;
	wire done, clk_ena, sclr_n;
	integer i;
	
	// Instantiate unit under test (mult_control)
	mult_control mult_control1 (.clk(clk), .reset_a(reset_a), .count(count),
		.input_sel(input_sel), .shift_sel(shift_sel), .state_out(state_out),
		.done(done), .clk_ena(clk_ena), .sclr_n(sclr_n), .start(start));

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
	
	// Process to control counter
	initial begin
		count = 2'd0;
		#125 ;
		for (i=0; i<4; i=i+1) begin
			count = count + 1;
			#50 ;
		end
	end
	
	// Start signal control
	initial begin
		start = 1'b0;
		#50 start = 1'b1;
		#50 start = 1'b0;
	end

endmodule
