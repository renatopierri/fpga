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

module counter_tb();

	// Wires to connect to DUT
	reg clk, aclr_n;
	wire [1:0] count_out;
	
	// Instantiate unit under test (counter)
	counter counter1 (.clk(clk), .aclr_n(aclr_n), .count_out(count_out));

	// Process to create clock signal
	initial begin
		clk = 0;
		forever clk = #20 ~clk;
	end
	
	// Assign input values to test register behavior
	initial begin
		aclr_n = 1'b0;
		#40 aclr_n = 1'b1;
	end

endmodule