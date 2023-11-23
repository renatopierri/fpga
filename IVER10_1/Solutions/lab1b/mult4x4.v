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

// Begin module and  port declaration for "mult4x4"
module mult4x4 (
	input [3:0] dataa, datab,  	// Declare data inputs "dataa" and "datab"
	output [7:0] product 		// Declare data output "product"
);

	// Set product equal to dataa times datab
	assign product = dataa * datab;

endmodule // End module

