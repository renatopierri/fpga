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

// Begin module declaration for "mux4"
module mux4(
	input [3:0] mux_in_a, mux_in_b, // Declare data input "mux_in_a" and "mux_in_b"
	input mux_sel,  				//  Declare control input (select line)
	output reg [3:0] mux_out  		// Declare data output "mux_out"
);
 
	// Create process sensitive to  all inputs
	always@(mux_in_a, mux_in_b, mux_sel) begin
		if (mux_sel == 1'b0)
			mux_out = mux_in_a;
		else
			mux_out = mux_in_b;
    end


endmodule // End module
