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
*******************************************************************************/s

// Begin module declaration for "reg16"
module reg16 (
	input [15:0] datain,		// Declare data input "datain"
	input clk, sclr_n, clk_ena,	// Declare control inputs "clk", "clkena" and "sclr_n"
	output reg [15:0] reg_out	// Declare data output "reg_out"
);

	// Create sequential process sensitive to clock
	always@(posedge clk) begin
		// Use nested if-else statements to add synchronous clock enable and clear controls
		if (clk_ena)
			if(!sclr_n)
				reg_out <= 16'b0 ;
			else
				reg_out <= datain;
	end // End process

endmodule // End module
