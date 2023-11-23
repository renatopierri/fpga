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

module shifter_tb();

	// Wires to connect to DUT
	reg [7:0] inp;
	reg [1:0] shift_cntrl;
	wire [15:0] shift_out;
	
	// Instantiate unit under test (shifter)
	shifter shifter1 (.inp(inp), .shift_cntrl(shift_cntrl), .shift_out(shift_out));

	// Assign values to "inp" and "shift_cntrl" to test shifter block
	initial begin
		shift_cntrl = 4'd0;  	// Initialize shift_cntrl to 0
		inp = 8'hF4;			// Fix inp to f4 hex
		forever
			#50 shift_cntrl = shift_cntrl + 1;  // Create counter on shift control input to cycle through values every 50 ns
	end

endmodule