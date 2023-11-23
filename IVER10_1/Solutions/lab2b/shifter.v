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

// Begin module declaration for "shifter"
module shifter(
	input [7:0] inp,			// Declare data input "inp"
	input [1:0] shift_cntrl,	// Declare control input "shift_cntrl"
	output reg [15:0] shift_out	// Declare data output "shift_out"
);
 
	// Create process sensitive to  all inputs
	always@(inp, shift_cntrl) begin
		// If-else statement to define shifting behavior on shift_out based on shift_cntrl
		if (shift_cntrl == 2'b01)
			shift_out = (inp << 4);
		else if (shift_cntrl == 2'b10)
			shift_out = (inp << 8);
		else
			shift_out = inp;
	end

endmodule // End module 
