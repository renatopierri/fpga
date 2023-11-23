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

module mux4_tb();

	// Wires to connect to DUT
	reg [3:0] mux_in_a, mux_in_b;
	reg mux_sel;
	wire [3:0] mux_out;
	
	// Instantiate unit under test (mux4)
	mux4 mux4_1 (.mux_in_a(mux_in_a), .mux_in_b(mux_in_b), .mux_sel(mux_sel),
		.mux_out(mux_out));

	// Initialize data inputs to mux4 block
	initial begin
		mux_in_a = 4'd9;  	// Initialize data to 0
		mux_in_b = 4'd7;	// Fix datab to 2
	end
	
	// Flip mux_sel between '0' and '1' every 50 ns
	initial begin
		mux_sel = 1'b1;
		forever
			#50 mux_sel = (mux_sel ? 1'b0 : 1'b1);
	end

endmodule