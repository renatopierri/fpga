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

// Begin module and  port declaration for "adder"
module adder (
	input [15:0] dataa, datab, 	// Declare data inputs "dataa" and "datab"
	output [15:0] sum  			// Declare data output "sum"
);

	//-- Set sum equal to dataa plus datab
	assign sum = dataa + datab;

endmodule // End module


