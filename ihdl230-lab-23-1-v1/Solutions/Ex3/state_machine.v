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

module state_machine_new (
	input clk, res,
	input chn1, sync, valid,
	output reg data_a, data_b, validate, error
);

parameter idle=5'b00000,
	header_wait=5'b00100, 
	got_header=5'b00001,
	a1=5'b10000, 
	a2=5'b10001, 
	a3=5'b10100, 
	b1=5'b01000, 
	b2=5'b01001, 
	b3=5'b01100, 
	recover=5'b00010;
	
reg [4:0] current_state, next_state;

always @ (posedge clk, posedge res)
begin: machine_transitions
	if (res)
		current_state <= idle;
	else
		current_state <= next_state;
end

always @ *
begin: next_state_decode
	case (current_state)
		idle: 	if (sync) next_state = header_wait;
				else next_state = idle;
		header_wait:
				if (valid) next_state = got_header;
				else next_state = header_wait;
		got_header:
				if (!chn1) next_state = a1;
				else next_state = b1;
		a1:		next_state = a2;
		b1:		next_state = b2;
		a2:		next_state = a3;
		b2:		next_state = b3;
		a3:		if (valid) next_state = header_wait;
				else next_state = recover;
		b3:		if (valid) next_state = header_wait;
				else next_state = recover;
		recover:
				if (sync) next_state = header_wait;
				else next_state = recover;
		default:
				next_state = idle;
	endcase
end

always @ (current_state)
begin:  machine_outputs
	data_a = 1'b0;
	data_b = 1'b0;
	validate = 1'b0;
	error = 1'b0;
	case (current_state)
		idle:			;
		header_wait:
				validate = 1'b1;
		a1:		data_a = 1'b1;
		a2:		data_a = 1'b1;
		a3:		begin
				data_a = 1'b1;
				validate = 1'b1;
				end
		b1:		data_b = 1'b1;
		b2:		data_b = 1'b1;	
		b3:		begin
				data_b = 1'b1;
				validate = 1'b1;
				end
		recover:
				error = 1'b1;
		default: ;
	endcase
end

endmodule
		