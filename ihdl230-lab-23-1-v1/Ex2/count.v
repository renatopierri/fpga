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

module count (
	input clk, aclr_n,
	output reg [7:0] q
);

initial q = 0;

always @(posedge clk, negedge aclr_n)
begin
	if (!aclr_n)
		q <= 0;
	else
		q <= q + 1'b1;
end

endmodule
