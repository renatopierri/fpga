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

module three_multb (
	input clk, clr_n,
	input [7:0] a, b, c, d,
	output reg [31:0] result
);

reg [7:0] atemp, btemp, ctemp, dtemp;

always @ (posedge clk, negedge clr_n)
begin
	if (!clr_n) begin
		atemp <= 8'h00;
		btemp <= 8'h00;
		ctemp <= 8'h00;
		dtemp <= 8'h00;
		result <= 32'h0000;
	end
	else begin
		atemp <= a;
		btemp <= b;
		ctemp <= c;
		dtemp <= d;
		result <= (atemp * btemp) * (ctemp * dtemp);
	end
end

endmodule
