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

module mult_no_inst
	//  Add an additional parameter that allows you to select 
	//         between a pipeline and non-pipelined implementation
	#(parameter AWIDTH = 8, BWIDTH = 9, CWIDTH = 10, DWIDTH = 11,
			PIPELINE = 0)
	(
	input clk, clr_n,
	input [AWIDTH-1:0] a_in,
	input [BWIDTH-1:0] b_in,
	input [CWIDTH-1:0] c_in,
	input [DWIDTH-1:0] d_in,
	output reg [(AWIDTH+BWIDTH+CWIDTH+DWIDTH)-1:0] result_out
);

	reg [AWIDTH-1:0] atemp;
	reg [BWIDTH-1:0] btemp;
	reg [CWIDTH-1:0] ctemp;
	reg [DWIDTH-1:0] dtemp;
	reg [(AWIDTH+BWIDTH)-1:0] abtemp;
	reg [(CWIDTH+DWIDTH)-1:0] cdtemp;

	//  This generate statement simply adds in an always block with 
	//      pipeline registers in the middle or one without.  This is
	//      the same codes from three_mult.v and three_mult_pipe.v but
	//      directly coded into the generate block.
	generate
	begin:  pipe_check
		if (PIPELINE != 0)
		begin:  pipeline_true
			always @ (posedge clk, negedge clr_n)
			begin
				if (!clr_n) begin
					atemp <= 0;
					btemp <= 0;
					ctemp <= 0;
					dtemp <= 0;
					abtemp <= 0;
					cdtemp <= 0;
					result_out <= 0;
				end
				else begin
					atemp <= a_in;
					btemp <= b_in;
					ctemp <= c_in;
					dtemp <= d_in;
					abtemp <= atemp * btemp;
					cdtemp <= ctemp * dtemp;
					result_out <=  abtemp * cdtemp;
				end
			end
		end
		else
		begin:  pipeline_not_true
			always @ (posedge clk, negedge clr_n)
			begin
				if (!clr_n) begin
					atemp <= 0;
					btemp <= 0;
					ctemp <= 0;
					dtemp <= 0;
					result_out <= 0;
				end
				else begin
					atemp <= a_in;
					btemp <= b_in;
					ctemp <= c_in;
					dtemp <= d_in;
					result_out <=  (atemp * btemp) * (ctemp * dtemp);
				end
			end
		end
	end
	endgenerate		
	

endmodule
