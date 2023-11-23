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

// Begin  module declaration for "counter"
module counter (
	input clk, aclr_n,			// Declare control inputs "clk" and "aclr_n"
	output reg [1:0] count_out	// Declare data output "count_out"
);

	// Create sequential process sensitive to clock and asynchronous clear
	always@(posedge clk, negedge aclr_n) begin
		// Use if-else statement to test for asynchronous control signal first;
		if (aclr_n == 1'b0)
			count_out <= 2'b0;
		else  // If asynchronous clear not asserted the count on rising clock edge
			count_out <= count_out + 1'b1;
    end // End process

endmodule // End module

