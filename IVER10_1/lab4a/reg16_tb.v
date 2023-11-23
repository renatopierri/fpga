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

module reg16_tb();

	// Wires to connect to DUT
	reg clk, clk_ena, sclr_n;
	reg[15:0] datain;
	wire [15:0] reg_out;
	
	// Instantiate unit under test (reg16)
	reg16 reg16_1 (.clk(clk), .clk_ena(clk_ena), .sclr_n(sclr_n),
		.datain(datain), .reg_out(reg_out));

	// Process to create clock signal
	initial begin
		clk = 0;
		forever clk = #20 ~clk;
	end
	
	// Assign input values to test register behavior
	initial begin
		clk_ena = 1'b0;
		sclr_n = 1'b0;
		datain = 16'h1F1F;
		#40 ;
		clk_ena = 1'b1;
		#40 ;
		sclr_n = 1'b1;
		#40 ;
		datain = 16'h4567;
		clk_ena = 1'b0;
		#40 ;
		clk_ena = 1'b1;
		#40 ;
		sclr_n = 1'b0;
	end

endmodule
