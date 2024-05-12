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

// Set the timescale and the clock period to use for the testbench (Part 1)
`timescale 1 ns/1 ns
`define CLOCK_PERIOD 20

module three_mult_tb ();

// Declare signals needed to connect to DUT (Part 1)
reg clk, clr_n;
reg [7:0] a, b, c, d;
wire [31:0] result;


// Declare testbench internal signals (Part 2)
reg [7:0] mem [0:31];
reg [7:0] exp [0:15];
integer i, j;

	
// Create clock signal (Part 1)
initial
begin
	clk = 1'b0;
	forever #(`CLOCK_PERIOD/2) clk = ~clk;
end


// Create reset pattern (Part 1)
initial
begin
	clr_n = 1'b0;
	#40 clr_n = 1'b1;
end


// Initialize all data inputs to 1 (Part 1)
initial
begin
    a = 1'b1;
    b = 1'b1;
    c = 1'b1;
    d = 1'b1;
end


//   For input a, create a count pattern that waits until 
//   after reset is de-asserted and then begins counting.
//   It should count up on every 3rd falling clock edge with no end (Part 1)
initial
begin
    @(posedge clr_n) ;
    forever
    begin
       repeat (3) @(negedge clk) ;
       a = a + 1'b1;
    end
end

//  For input b, specify the following signal pattern (Part 1)
//  Time   Value
//   100       2
//   160       3
//   200       4
//   500       5
//   800       7
initial
begin
    #100 b = 8'd2;
    #60 b = 8'd3;
    #40 b = 8'd4;
    #300 b = 8'd5;
    #300 b = 8'd7;
end


// Instantiate DUT (Part 1)
three_multb test_mod (
	.clk(clk), .clr_n(clr_n),
	.a(a), .b(b), .c(c), .d(d),
	.result(result));
	

//    Create a memory named mem (above) in which to load text file "input.dat".
//    Read file into memory.  After reset has been de-asserted, assign
//    the first two memory values to inputs c and d on the falling edge of the 
//    clock.  After that, on every 5th falling edge clock, read in two more values
//    from the memory into c and d until all remaining 15 pairs of values have
//    been read.  (Part 2)
initial
begin
    $readmemh("input.dat",mem);
    @(posedge clr_n) ; 
    @(negedge clk) begin
       c = mem[0];
       d = mem[1];
    end
    for (i = 1; i <= 15; i = i + 1)
    begin
        repeat (5) @ (negedge clk) ;
        c = mem[i*2];
        d = mem[i*2+1];
    end
end


//     Create a memory named exp_res (above) in which to load expected results
//     file "expected.dat".  Like with the test vectors, we want to read them 
//     into memory and then wait until reset has been de-asserted.  
//     Then, we can use a for loop to loop through the expected results
//     comparing them against the design generated results.  Use the compare
//     routine below to perform comparisons.  There is also an additional 
//     2-cycle delay before the first result appears so this must be accounted for.
//     After that, perform checks on every 5th falling edge. (Part 2)
initial
begin
    $readmemh("expected.dat", exp);
    @(posedge clr_n) ;
    repeat (2) @(negedge clk) ;
    @(negedge clk) compare (0,result,exp[0]);
    for (j = 1; j <= 15; j = j + 1)
    begin
        repeat(5) @ (negedge clk) ;
        compare (j,result,exp[j]);
    end
end
    
// Task to compare and display results
task compare (
   input integer v,
   input [31:0] gen_res, exp_res
);
   if (gen_res != exp_res)
   begin
      $display("****Calc #%0d INCORRECT****", v);
      $display("%d calculated, expected %d", gen_res, exp_res);
   end
   else
   begin
      $display("Calc #%0d is just fine!!", v);
      $display("%d calculated, expected %d", gen_res, exp_res);
   end
endtask


// Quit simulating after 1 us.  It's not the end of the stimulus, but it should
// be good enough to see if things are working correctly.  You will extend it
// in Part 2.
initial #1000 $stop;


endmodule