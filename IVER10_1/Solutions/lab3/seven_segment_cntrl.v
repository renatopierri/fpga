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

// Begin module declaration for "seven_segment_cntrl"
module seven_segment_cntrl (
	input [2:0] inp,						//Declare data input "inp
	output reg seg_a, seg_b, seg_c, seg_d,	// Declare data outputs 'seg_a', 'seg_b', 'seg_c', 'seg_d',
	output reg seg_e, seg_f, seg_g			// Declare data outputs 'seg_e', 'seg_f', 'seg_g'
);

	// Begin process sensitive to inp
	always@ (inp) begin
		// Case statement to control segments of seven segment display
		case(inp)
			// 7-segment display reads '0' when input equals "000"
			3'B000 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1111110;	
			// 7-segment display reads '1' when input equals "001"
			3'B001 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b0110000;	
			// 7-segment display reads '2' when input equals "010"
			3'B010 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1101101;
			// 7-segment display reads '3' when input equals "011"
			3'B011 : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1111001;
			// 7-segment display reads 'E' for error when input equals any other bit pattern
			default : {seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g} = 7'b1001111;
		endcase
	end // End process

endmodule // end module
