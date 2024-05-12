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

module mult
	//  Add an additional parameter that allows you to select 
	//         between a pipelined and a non-pipelined implementation
	#(parameter AWIDTH = 8, BWIDTH = 9, CWIDTH = 10, DWIDTH = 11)
	(
	input clk, clr_n,
	input [AWIDTH-1:0] a_in,
	input [BWIDTH-1:0] b_in,
	input [CWIDTH-1:0] c_in,
	input [DWIDTH-1:0] d_in,
	output [(AWIDTH+BWIDTH+CWIDTH+DWIDTH)-1:0] result_out
);

	//  Add generate (if-else or case) to allow the parameter to choose
	//      between an instantiation of a non-pipelined or a pipelined 
	//      multiplier implementation.  Set the non-pipelined implementation
	//      as the default.
		
	

endmodule
