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

// Begin module declaration for "mult_control"
module mult_control (
	input clk, reset_a, start,				// Declare control inputs "clk", "reset_a", "start", "count"
	input [1:0] count,
	output reg [1:0] input_sel, shift_sel,	// Declare output control signals "in_sel", "shift_sel", 
	output reg [2:0] state_out,				//       "state_out", "done", "clk_ena" and "sclr_n"
	output reg done, clk_ena, sclr_n
);

	// Declare two variables named "current_state" and "next_state" to be state variables
	reg [2:0] current_state, next_state;
	
	// Declare parameters /states consisting of 6 values:  "idle", "lsb", "mid", "msb", "calc_done" and "err"
	parameter idle=0, lsb=1, mid=2, msb=3, calc_done=4, err=5;

	// Create sequential process to control state transitions by making current_state equal to next state on
	//	rising edge transitions; Use asynchronous clear control
	always @(posedge clk, posedge reset_a) begin
		if (reset_a)
			current_state <= idle;
		else
			current_state <= next_state;
	end
		
	// Create combinational process & case statement to determine next_state based on current state and inputs
	always @ *
		case (current_state)
			idle : 
				if (start)
					next_state = lsb;
				else
					next_state = idle;
			lsb : 
				if (count == 0 && start == 0)
					next_state = mid;
				else
					next_state = err;
			mid : 
				if (start == 0 && count == 2)
					next_state = msb;
				else if (start == 0 && count == 1)
					next_state = mid;
				else
					next_state = err;
			msb : 
				if (count == 3 && start == 0)
					next_state = calc_done;
				else
					next_state = err;
			calc_done :
				if (!start)
					next_state = idle;
				else
					next_state = err;
			err : 
				if (start)
					next_state = lsb;
				else
					next_state = err;
		endcase

	// Create process for Mealy output logic for input_sel, shift_sel, done, clk_ena and sclr_n  (outputs function of inputs and current_state)
	always @* begin
		// Initialize outputs to default values so case only covers  when they change
		input_sel = 2'bxx;
		shift_sel = 2'bxx;
		done = 1'b0;
		clk_ena = 1'b0;
		sclr_n = 1'b1;		
		case (current_state)
			idle : 
				if (start) begin
					clk_ena = 1'b1;
					sclr_n = 1'b0;
				end
			lsb : 
				if (count == 0 && start == 0) begin
					input_sel = 2'd0;
					shift_sel = 2'd0;
					clk_ena = 1'b1;
				end
			mid : 
				if (count == 2 && start == 0) begin
					input_sel = 2'd2;
					shift_sel = 2'd1;
					clk_ena = 1'b1;
				end
				else if (count == 1 && start == 0) begin
					input_sel = 1'd1;
					shift_sel = 1'd1;
					clk_ena = 1'b1;
				end
			msb : 
				if (count == 3 && start == 0) begin
					input_sel = 2'd3;
					shift_sel = 2'd2;
					clk_ena = 1'b1;
				end
			calc_done :
				if (!start)
					done = 1'b1;
			err : 
				if (start) begin
					clk_ena = 1'b1;
					sclr_n = 1'b0;
				end
		endcase
	end

	// Create process for Moore output logic for state_out  (outputs function of current_state only)
	always @(current_state) begin
		// Initialize state_out to default values so case only covers when they change
		state_out = 3'd0;
		case (current_state)
			idle : ;
			lsb : state_out = 3'd1;
			mid : state_out = 3'd2;
			msb : state_out = 3'd3;
			calc_done : state_out = 3'd4;
			err : state_out = 3'd5;
		endcase
	end

endmodule // End module

			



	
