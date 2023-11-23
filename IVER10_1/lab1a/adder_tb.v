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

module adder_tb();

	// Wires and variables to connect to DUT
	reg [15:0] dataa, datab;
	wire [15:0] sum;
	
	// Instantiate unit under test (adder)
	adder adder1 (.dataa(dataa), .datab(datab), .sum(sum));

	// Assign values to "dataa" and "datab" to test adder block
	initial begin
		dataa = 16'd8;
		datab = 16'd5;
		#20 dataa = 16'd0;
		datab = 16'd1;
		#10 dataa = 16'd10;
		datab = 16'd4;	
	end

endmodule
