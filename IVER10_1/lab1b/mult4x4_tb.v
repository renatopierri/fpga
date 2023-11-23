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

module mult4x4_tb();

	// Wires to connect to DUT
	reg [3:0] dataa, datab;
	wire [7:0] product;
	
	// Instantiate unit under test (mult4x4)
	mult4x4 mult4x4_1 (.dataa(dataa), .datab(datab), .product(product));

	// Assign values to "dataa" and "datab" to test mult4x4 block
	initial begin
		dataa = 4'd0;  	// Initialize data to 0
		datab = 4'd2;	// Fix datab to 2
		forever
			#10 dataa = dataa + 3;  // Increment dataa by 3 every 10 ns
	end

endmodule