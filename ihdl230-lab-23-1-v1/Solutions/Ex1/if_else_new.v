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

module if_else_new(
	input [8:0] state,
	input x, y, z,
	output [2:0] state_out
);

reg out1, out2, out3;

parameter	s0 = 9'b000000000, s1 = 9'b100000001, s2 = 9'b100000010, s3 = 9'b100000100, s4 = 9'b100001000,
				s5 = 9'b100010000, s6 = 9'b100100000, s7 = 9'b101000000, s8 = 9'b110000000;

always @ * begin
		out1 = 1'b0;
		out2 = 1'b0;
		out3 = 1'b0;	
	if ((state == s1) || (state == s3) || (state == s4))
		out1 = x;
	if ((state == s0) || (state == s2) || (state == s5))
		out2 = y;
	if ((state == s6) || (state == s7) || (state == s8))
		out3 = z;
end

assign state_out = {out1, out2, out3};

endmodule