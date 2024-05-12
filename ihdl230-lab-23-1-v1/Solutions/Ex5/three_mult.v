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

// This design takes in 4 adjustable width inputs and multiplies them all together

module three_mult 
	#(parameter AWIDTH = 8, BWIDTH = 8, CWIDTH = 8, DWIDTH = 8)  // Sets the bus widths on the individual inputs
	(
	input clk, clr_n,
	input [AWIDTH-1:0] a,
	input [BWIDTH-1:0] b,
	input [CWIDTH-1:0] c,
	input [DWIDTH-1:0] d,
	output reg [(AWIDTH+BWIDTH+CWIDTH+DWIDTH)-1:0] result
);

reg [AWIDTH-1:0] atemp;
reg [BWIDTH-1:0] btemp;
reg [CWIDTH-1:0] ctemp;
reg [DWIDTH-1:0] dtemp;

always @ (posedge clk, negedge clr_n)
begin
	if (!clr_n) begin
		atemp <= 0;
		btemp <= 0;
		ctemp <= 0;
		dtemp <= 0;
		result <= 0;
	end
	else begin
		atemp <= a;
		btemp <= b;
		ctemp <= c;
		dtemp <= d;
		result <=  (atemp * btemp) * (ctemp * dtemp);
	end
end

endmodule
