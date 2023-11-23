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

module seven_segment_cntrl_tb();

	// Wires to connect to DUT
	reg [2:0] inp;
	wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;
	
	// Instantiate unit under test (seven_segment_cntrl)
	seven_segment_cntrl seven_segment_cntrl1 (.inp(inp), .seg_a(seg_a), .seg_b(seg_b),
		.seg_c(seg_c), .seg_d(seg_d), .seg_e(seg_e), .seg_f(seg_f), .seg_g(seg_g));
	
	// Assign values to "inp" to test seven_segment_cntrl block
	initial begin
		inp = 3'd0;  	// Initialize inp to 0
		forever
			#50 inp = inp + 1;  // Set input equal to values 0 - 7 for  50 ns each
	end

endmodule