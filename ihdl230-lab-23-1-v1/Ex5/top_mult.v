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

module top_mult (
	input [11:0] a_top, b_top, c_top, d_top,
	input clk, clr_n,
	output [47:0] result_top
);

//  This code uses a setting of 0 to indicate non-pipelined or non-zero to indicate
//         pipelined.  Feel free to change the logic if you implemented your pipeline
//         test differently.
mult #(.PIPELINE(0), .AWIDTH(12), .BWIDTH(12),
		.CWIDTH(12), .DWIDTH(12))
	mult_inst (.clk(clk), .clr_n(clr_n), 
		.a_in(a_top), .b_in(b_top),
		.c_in(c_top), .d_in(d_top),
		.result_out(result_top));
		
endmodule
